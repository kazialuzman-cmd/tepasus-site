$Out = "tepasus-site"
Remove-Item -Recurse -Force $Out, tepasus-site.zip -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path "$Out\.github\workflows" -Force | Out-Null
# Save index.html: paste the full HTML content into this file
Set-Content -Path "$Out\index.html" -Value @"
<!doctype html>
<html lang="id">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>TEPASUS CCTV | Service & Pemasangan CCTV Profesional</title>
  <!-- paste full content here -->
</head>
<body>
</body>
</html>
"@
Set-Content -Path "$Out\.github\workflows\deploy.yml" -Value @"
name: Deploy to GitHub Pages
on:
  push:
    branches:
      - main
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./
          publish_branch: gh-pages
"@
Set-Content -Path "$Out\CNAME" -Value "tepasuscctv.co.id"
Compress-Archive -Path $Out -DestinationPath tepasus-site.zip -Force
Write-Host "Created tepasus-site.zip"