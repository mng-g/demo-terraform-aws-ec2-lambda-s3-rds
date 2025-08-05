import logging
import os
import json
import boto3
import psycopg2
from botocore.exceptions import ClientError
from typing import Any, Dict

logging.basicConfig(level=logging.INFO)

def lambda_handler(event: Dict[str, Any], context: Any) -> Dict[str, Any]:
    """
    AWS Lambda entry point. Routes requests based on path and method.
    Handles CORS and preflight requests.
    """
    logging.info("EVENT: %s", json.dumps(event))
    
    method = event.get("httpMethod", "")
    path = event.get("rawPath") or event.get("path", "")
    stage = event.get("requestContext", {}).get("stage")
    if stage and path.startswith(f"/{stage}"):
        path = path[len(stage) + 1 :] if path.startswith(f"/{stage}/") else "/"

    # Handle preflight CORS requests
    if method == "OPTIONS":
        return {
            "statusCode": 200,
            "headers": cors_headers(),
            "body": json.dumps({"message": "CORS preflight OK"})
        }

    status_code = 200
    response_body = {}

    if path == "/api/s3-test":
        response_body = handle_s3_test()
    elif path == "/api/rds-test":
        response_body = handle_rds_test()
    elif path == "/healthz":
        response_body = {"status": "ok"}
    else:
        status_code = 404
        response_body = {"error": "Not Found"}

    return {
        "statusCode": status_code,
        "headers": cors_headers({"Content-Type": "application/json"}),
        "body": json.dumps(response_body)
    }

def cors_headers(extra: Dict[str, str] = None) -> Dict[str, str]:
    """
    Returns headers required for CORS.
    """
    headers = {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET,POST,OPTIONS",
        "Access-Control-Allow-Headers": "Content-Type"
    }
    if extra:
        headers.update(extra)
    return headers

def handle_s3_test() -> Dict[str, Any]:
    bucket = os.environ.get("S3_BUCKET")
    if not bucket:
        error_msg = "S3_BUCKET environment variable not set"
        logging.error(error_msg)
        return {"success": False, "error": error_msg}

    s3 = boto3.client("s3")
    result = {"success": True, "files": []}
    try:
        test_key = "lambda-test.txt"
        s3.put_object(Bucket=bucket, Key=test_key, Body=b"test-lambda")
        logging.info(f"Successfully wrote test file: {test_key}")
        obj = s3.get_object(Bucket=bucket, Key=test_key)
        content = obj["Body"].read().decode()
        logging.info(f"Successfully read test file: {test_key}")

        paginator = s3.get_paginator("list_objects_v2")
        for page in paginator.paginate(Bucket=bucket):
            for obj in page.get("Contents", []):
                result["files"].append({
                    "key": obj["Key"],
                    "size": obj["Size"],
                    "last_modified": obj["LastModified"].isoformat() if hasattr(obj["LastModified"], "isoformat") else str(obj["LastModified"])
                })
        return result
    except ClientError as e:
        error_msg = f"AWS S3 error: {str(e)}"
        logging.error(error_msg)
        return {"success": False, "error": error_msg}
    except Exception as e:
        error_msg = f"Unexpected error: {str(e)}"
        logging.error(error_msg)
        return {"success": False, "error": error_msg}

def handle_rds_test() -> Dict[str, Any]:
    host = os.environ.get("DB_HOST")
    port = os.environ.get("DB_PORT", "5432")
    dbname = os.environ.get("DB_NAME")
    user = os.environ.get("DB_USER")
    password = os.environ.get("DB_PASSWORD")
    
    missing_vars = []
    if not host: missing_vars.append("DB_HOST")
    if not dbname: missing_vars.append("DB_NAME")
    if not user: missing_vars.append("DB_USER")
    if not password: missing_vars.append("DB_PASSWORD")
    
    if missing_vars:
        error_msg = f"Missing required environment variables: {', '.join(missing_vars)}"
        logging.error(error_msg)
        return {"success": False, "db_version": None, "error": error_msg}
    
    dsn = f"host={host} port={port} dbname={dbname} user={user} password={password}"
    
    try:
        logging.info(f"Attempting to connect to RDS at {host}:{port}")
        conn = psycopg2.connect(
            host=host,
            port=port,
            dbname=dbname,
            user=user,
            password=password,
            connect_timeout=5
        )
        
        with conn.cursor() as cur:
            cur.execute("SELECT version();")
            version = cur.fetchone()[0]
            logging.info(f"Successfully connected to RDS. Version: {version}")
            return {"success": True, "db_version": version}
            
    except psycopg2.OperationalError as e:
        error_msg = f"RDS connection failed: {str(e)}"
        logging.error(error_msg)
        return {"success": False, "db_version": None, "error": error_msg}
    except Exception as e:
        error_msg = f"Unexpected error: {str(e)}"
        logging.error(error_msg)
        return {"success": False, "db_version": None, "error": error_msg}
    finally:
        if 'conn' in locals():
            conn.close()
