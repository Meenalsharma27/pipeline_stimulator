git pull

git log --all --pretty=format:"%h | %an | %ad | %s" --date=short > commit_logs.txt

git add commit_logs.txt

git commit -m "docs: update team commit logs"

git push