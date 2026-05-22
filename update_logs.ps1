git switch Demo

git pull origin Demo

git log --all --pretty=format:"%h | %an | %ad | %s" --date=short > commit_logs.txt

git add commit_logs.txt commit_guidelines.md update_logs.ps1

git commit -m "R25SK000: Update team commit logs"

git push origin Demo


