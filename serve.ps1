# Native PowerShell HTTP server for serving the static website clone
$port = 5173
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")

Write-Host "==============================================" -ForegroundColor Green
Write-Host "  Static Web Server Running Local Clone" -ForegroundColor Green
Write-Host "  URL: http://localhost:$port/" -ForegroundColor Cyan
Write-Host "  Press Ctrl+C in this terminal to stop." -ForegroundColor Yellow
Write-Host "==============================================" -ForegroundColor Green

try {
    $listener.Start()
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        try {
            $request = $context.Request
            $response = $context.Response
            $rawPath = $request.Url.LocalPath
            
            Write-Host "$(Get-Date -Format 'HH:mm:ss') - $($request.HttpMethod) - $rawPath" -ForegroundColor Gray
            
            # Security check: prevent directory traversal
            if ($rawPath -like "*..*") {
                $response.StatusCode = 403
                continue
            }
            
            # Clean URL mapping: strip leading slash, resolve file path relative to this script
            $cleanPath = $rawPath.TrimStart('/')
            $filePath = Join-Path $PSScriptRoot $cleanPath
            
            # If path points to a directory, map to index.html in that directory
            if (Test-Path -Path $filePath -PathType Container) {
                $filePath = Join-Path $filePath "index.html"
            }
            
            if (Test-Path -Path $filePath -PathType Leaf) {
                $bytes = [System.IO.File]::ReadAllBytes($filePath)
                
                # Determine correct MIME Content-Type
                $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
                $mimeType = switch ($ext) {
                    ".html" { "text/html; charset=utf-8" }
                    ".css"  { "text/css; charset=utf-8" }
                    ".js"   { "application/javascript; charset=utf-8" }
                    ".png"  { "image/png" }
                    ".jpg"  { "image/jpeg" }
                    ".jpeg" { "image/jpeg" }
                    ".gif"  { "image/gif" }
                    ".svg"  { "image/svg+xml" }
                    ".ico"  { "image/x-icon" }
                    default { "application/octet-stream" }
                }
                
                $response.ContentType = $mimeType
                $response.StatusCode = 200
                $response.ContentLength64 = $bytes.Length
                
                # Only write body content if HttpMethod is not HEAD
                if ($request.HttpMethod -ne "HEAD") {
                    $response.OutputStream.Write($bytes, 0, $bytes.Length)
                }
            } else {
                $response.StatusCode = 404
                $errBytes = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: $rawPath")
                $response.ContentType = "text/plain; charset=utf-8"
                $response.ContentLength64 = $errBytes.Length
                if ($request.HttpMethod -ne "HEAD") {
                    $response.OutputStream.Write($errBytes, 0, $errBytes.Length)
                }
            }
        } catch {
            Write-Host "Error processing request: $_" -ForegroundColor Red
        } finally {
            # Safely close response output stream if possible
            if ($context -and $context.Response) {
                try {
                    $context.Response.OutputStream.Close()
                } catch {}
            }
        }
    }
} catch {
    Write-Error "Server stopped due to outer error: $_"
} finally {
    $listener.Close()
    Write-Host "Server stopped." -ForegroundColor Red
}
