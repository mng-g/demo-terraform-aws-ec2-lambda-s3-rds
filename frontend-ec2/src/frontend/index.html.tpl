<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Welcome to Awesomeness</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="icon" href="data:,">
  <style>
    .loading {
      animation: pulse 2s infinite;
    }
    @keyframes pulse {
      0% { transform: scale(1); }
      50% { transform: scale(1.1); }
      100% { transform: scale(1); }
    }
  </style>
</head>
<body class="bg-gradient-to-br from-purple-900 to-black text-white h-screen flex items-center justify-center">
  <div class="text-center animate-pulse">
    <h1 class="text-6xl font-bold mb-6">🚀 Welcome to the Future 🚀</h1>
    <p class="text-xl">Hosted on Amazon Linux. Powered by Nginx. Made with love. 💻🌐</p>
    <p class="mt-4 text-sm opacity-70">Your move, internet.</p>

    <div class="mt-8">
      <span class="inline-block px-4 py-2 bg-purple-700 rounded text-lg font-mono">Environment: <span id="env-label"></span></span>
    </div>

    <div class="mt-8 flex justify-center space-x-4">
      <button id="s3-test-btn" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">S3 Test</button>
      <button id="rds-test-btn" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">RDS Test</button>
    </div>

    <div class="mt-4">
      <div id="s3-status" class="text-lg font-mono"></div>
      <div id="rds-status" class="text-lg font-mono"></div>
    </div>

    <div id="error-message" class="mt-4 text-lg font-mono text-red-500"></div>
  </div>

  <script>
    const ENV = "${env}";
    const API_URL = "${api_url}";
  </script>
  <script src="script.js"></script>
</body>
</html>
