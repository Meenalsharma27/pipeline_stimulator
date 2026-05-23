git switch Demo

git pull origin Demo

git log --all --pretty=format:"%h | %an | %ad | %s" --date=short | Out-File -FilePath commit_logs.txt -Encoding utf8

git add commit_logs.txt commit_guidelines.md update_logs.ps1

git commit -m "R25SK000: Update team commit logs"

git push origin Demo
