# Simple web server to serve the built app
Write-Host "=== Starting Web Server ===" -ForegroundColor Cyan
Write-Host ""

$buildPath = "build\web"
if (-not (Test-Path $buildPath)) {
    Write-Host "Building web app first..." -ForegroundColor Yellow
    C:\src\flutter\bin\flutter.bat build web --release
}

if (Test-Path $buildPath) {
    Write-Host "Starting web server on http://localhost:8080" -ForegroundColor Green
    Write-Host "Press Ctrl+C to stop" -ForegroundColor Yellow
    Write-Host ""
    
    # Use Python's http.server if available, otherwise PowerShell
    $python = Get-Command python -ErrorAction SilentlyContinue
    if ($python) {
        Set-Location $buildPath
        python -m http.server 8080
    } else {
        # PowerShell simple server
        $listener = New-Object System.Net.HttpListener
        $listener.Prefixes.Add("http://localhost:8080/")
        $listener.Start()
        Write-Host "Server started at http://localhost:8080" -ForegroundColor Green
        Write-Host "Open this URL in your browser!" -ForegroundColor Cyan
        
        while ($listener.IsListening) {
            $context = $listener.GetContext()
            $request = $context.Request
            $response = $context.Response
            
            $localPath = $request.Url.LocalPath
            if ($localPath -eq "/") { $localPath = "/index.html" }
            
            $filePath = Join-Path $buildPath $localPath.TrimStart('/')
            if (Test-Path $filePath) {
                $content = [System.IO.File]::ReadAllBytes($filePath)
                $response.ContentLength64 = $content.Length
                $response.OutputStream.Write($content, 0, $content.Length)
            } else {
                $response.StatusCode = 404
            }
            $response.Close()
        }
    }
} else {
    Write-Host "Build failed. Please check errors above." -ForegroundColor Red
}

