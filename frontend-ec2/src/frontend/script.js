document.addEventListener("DOMContentLoaded", function () {
    document.getElementById('env-label').textContent = ENV;
  
    const s3TestBtn = document.getElementById('s3-test-btn');
    const rdsTestBtn = document.getElementById('rds-test-btn');
    const s3Status = document.getElementById('s3-status');
    const rdsStatus = document.getElementById('rds-status');
    const errorMessage = document.getElementById('error-message');
  
    s3TestBtn.addEventListener('click', async () => {
      try {
        s3Status.textContent = 'Loading...';
        s3Status.classList.add('loading');
        const response = await fetch(`${API_URL}/api/s3-test`);
        const data = await response.json();
        if (data.success) {
          s3Status.textContent = `S3 Test: ${data.files.length} file(s) found`;
        } else {
          s3Status.textContent = `S3 Test Failed: ${data.error}`;
        }
        s3Status.classList.remove('loading');
      } catch (error) {
        errorMessage.textContent = 'Error: Unable to reach backend';
        s3Status.classList.remove('loading');
      }
    });
  
    rdsTestBtn.addEventListener('click', async () => {
      try {
        rdsStatus.textContent = 'Loading...';
        rdsStatus.classList.add('loading');
        const response = await fetch(`${API_URL}/api/rds-test`);
        const data = await response.json();
        if (data.success) {
          rdsStatus.textContent = `RDS Test: ${data.db_version}`;
        } else {
          rdsStatus.textContent = `RDS Test Failed: ${data.error}`;
        }
        rdsStatus.classList.remove('loading');
      } catch (error) {
        errorMessage.textContent = 'Error: Unable to reach backend';
        rdsStatus.classList.remove('loading');
      }
    });
  });
  