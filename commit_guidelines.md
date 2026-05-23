# Commit Guidelines

## Purpose
This document defines the standard commit message format and commit practices for the project team.  
Following proper commit conventions helps maintain:
- clean Git history
- better collaboration
- easier debugging
- professional project management

---

# General Rules

## 1. Write Meaningful Commit Messages

Commit messages should clearly describe:
- what was changed
- why it was changed

### Good Examples
```bash
docs: add commit guidelines
pipeline: add FastQC workflow
docker: update Docker configuration
ui: fix navbar alignment
backend: add PUT API endpoint
```

### Bad Examples
```bash
update
done
changes
final
test
```

---

# 2. Use Present Tense

Preferred:
```bash
Add login feature
Fix CSS issue
Update workflow
```

Avoid:
```bash
Added login feature
Fixed issue
Updated workflow
```

---

# 3. Recommended Commit Format

Use the following format:

```bash
<module>: <short description>
```

## Examples

### Documentation
```bash
docs: update README
docs: add installation guide
```

### Frontend/UI
```bash
ui: fix navbar responsiveness
ui: add dashboard page
```

### Backend/API
```bash
backend: add authentication route
backend: fix database connection
```

### Docker
```bash
docker: add Dockerfile
docker: update docker-compose
```

### Pipeline/Bioinformatics
```bash
pipeline: add FastQC step
pipeline: update Snakemake workflow
```

---

# 4. Keep Commits Small and Focused

Each commit should represent one logical change.

## Good Practice
- one feature = one commit
- one bug fix = one commit

## Avoid
- multiple unrelated changes in one commit

---

# 5. Pull Latest Changes Before Commit

Always update your local repository before starting work:

```bash
git pull
```

---

# 6. Check Changes Before Commit

Review modified files:

```bash
git status
```

Review actual code changes:

```bash
git diff
```

---

# 7. Commit Workflow

## Step 1 — Check status
```bash
git status
```

## Step 2 — Add files
```bash
git add .
```

OR specific file:
```bash
git add filename
```

## Step 3 — Commit changes
```bash
git commit -m "module: meaningful message"
```

## Step 4 — Push changes
```bash
git push
```

---

# 8. Team Commit Log Commands

## View all commits
```bash
git log --all --oneline
```

## Detailed commit history
```bash
git log --all --stat
```

## Contributor summary
```bash
git shortlog -sn --all
```

## Export commit logs
```bash
git log --all --pretty=format:"%h | %an | %ad | %s" --date=short > commit_logs.txt
```

---

# 9. Commit Log File

Team commit history is maintained in:

```text
commit_logs.txt
```

This file contains:
- commit ID
- author name
- commit date
- commit message

Example:
```text
5916f92 | Meenalsharma27 | 2026-05-20 | Initial commit
a12bc34 | Afreen Khanam | 2026-05-21 | docs: update README
```

---

# 10. Avoid These Mistakes

## Do Not
- commit unnecessary files
- commit temporary/debug code
- use unclear commit messages
- push broken code
- commit large unrelated changes together

---


## Important Guideline: If You Accidentally Push to `main`

Never push directly to the `main` branch unless explicitly allowed.

### If you accidentally pushed to `main`

#### Step 1 — Inform the team immediately

Mention:

* commit ID
* what was changed
* whether it is safe or needs revert

---

## Important: Always Pull Before Push

Before pushing any revert or fix to `main`, always run:

```bash id="mb4g2z"
git pull origin main
```

Why this is necessary:

* gets latest remote commits
* avoids push conflicts
* prevents overwriting teammates' work
* ensures revert is applied on latest repository state

Especially important during revert operations because other developers may have pushed new commits meanwhile.

---

#### Step 2 — Do NOT force push

Never use:

```bash id="u6d8kp"
git push --force
```

on `main` unless instructed by maintainers.

---

#### Step 3 — Create a revert commit (preferred method)

View commit history:

```bash id="w8s2rn"
git log --oneline
```

Revert the accidental commit:

```bash id="t2m4ye"
git revert <commit_id>
```

Example:

```bash id="j5c7ql"
git revert d5a713
```

This creates a new commit that safely undoes the changes.

---

#### Step 4 — Pull latest changes again before pushing

```bash id="m1p8va"
git pull origin main
```

Resolve conflicts if Git asks.

---

#### Step 5 — Push the revert

```bash id="p7x0fk"
git push origin main
```

---

#### Step 6 — Continue work in a feature branch

```bash id="q3n2yw"
git switch Demo
```

or

```bash id="c9v4ld"
git switch feature
```

---

## What NOT to do

Avoid:

```bash id="x5r1oz"
git reset --hard
git push --force
```

on shared branches like `main`.

These commands can remove teammates' work and rewrite repository history.

---

## Recommended Workflow

```bash id="k4e7sm"
git switch Demo

# make changes

git add .
git commit -m "Meaningful message"

git pull origin Demo

git push origin Demo
```

Then create a Pull Request to merge into `main`.


# Conclusion

Following these commit guidelines ensures:
- readable Git history
- efficient team collaboration
- easier code review
- better project maintenance