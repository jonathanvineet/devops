# Git Commands Guide

A quick reference guide for the most commonly used Git commands.

## Initial Setup

### Configure Git
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Verify Configuration
```bash
git config --list
git config user.name
git config user.email
```

## Creating & Cloning Repositories

### Initialize a New Repository
```bash
git init
```

### Clone a Repository
```bash
git clone <repository-url>
git clone <repository-url> <directory-name>
```

### Clone Specific Branch
```bash
git clone --branch <branch-name> <repository-url>
git clone -b <branch-name> <repository-url>
```

## Basic Workflow

### Check Repository Status
```bash
git status
```

### Stage Changes
```bash
# Stage specific file
git add <file-name>

# Stage all changes
git add .
git add -A

# Stage all modified files (not new files)
git add -u
```

### View Staged Changes
```bash
git diff --staged
git diff --cached
```

### View Unstaged Changes
```bash
git diff
```

### Commit Changes
```bash
git commit -m "Commit message"
git commit -m "Title" -m "Detailed description"
```

### Commit with Automatic Staging
```bash
git commit -am "Commit message"
```

## Viewing History

### View Commit Log
```bash
# Standard log
git log

# One-line format
git log --oneline

# Show last N commits
git log -n 5

# Show commits with changes
git log -p

# Show commits with statistics
git log --stat
```

### View Specific Commit
```bash
git show <commit-hash>
git show HEAD
```

### View Blame (who changed what)
```bash
git blame <file-name>
```

## Branches

### List Branches
```bash
# Local branches
git branch

# All branches (local and remote)
git branch -a

# Remote branches
git branch -r
```

### Create Branch
```bash
git branch <branch-name>
git branch <branch-name> <commit-hash>
```

### Switch Branch
```bash
# Old way
git checkout <branch-name>

# New way (Git 2.23+)
git switch <branch-name>
```

### Create and Switch to New Branch
```bash
git checkout -b <branch-name>
git switch -c <branch-name>
```

### Rename Branch
```bash
# Rename current branch
git branch -m <new-branch-name>

# Rename specific branch
git branch -m <old-branch-name> <new-branch-name>
```

### Delete Branch
```bash
# Delete local branch
git branch -d <branch-name>
git branch -D <branch-name>  # Force delete

# Delete remote branch
git push origin --delete <branch-name>
git push origin :<branch-name>
```

## Remote Repositories

### View Remote Repositories
```bash
git remote
git remote -v  # Verbose (shows URLs)
```

### Add Remote Repository
```bash
git remote add <remote-name> <repository-url>
git remote add origin <repository-url>
```

### Change Remote URL
```bash
git remote set-url <remote-name> <new-url>
```

### Remove Remote
```bash
git remote remove <remote-name>
```

### View Remote Details
```bash
git remote show <remote-name>
```

## Pushing & Pulling

### Push Changes
```bash
# Push current branch
git push

# Push to specific remote and branch
git push <remote-name> <branch-name>
git push origin main

# Push all branches
git push --all

# Push with tags
git push --tags
```

### Push New Branch to Remote
```bash
git push -u origin <branch-name>
```

### Pull Changes
```bash
# Fetch and merge
git pull

# From specific remote and branch
git pull <remote-name> <branch-name>
git pull origin main
```

### Fetch Changes (without merging)
```bash
# Fetch from all remotes
git fetch

# Fetch from specific remote
git fetch <remote-name>
```

## Merging & Rebasing

### Merge Branch
```bash
git merge <branch-name>
git merge --no-ff <branch-name>  # Create merge commit even if fast-forward
```

### Abort Merge
```bash
git merge --abort
```

### Rebase Branch
```bash
git rebase <branch-name>
```

### Interactive Rebase
```bash
git rebase -i <commit-hash>
git rebase -i HEAD~3  # Last 3 commits
```

### Abort Rebase
```bash
git rebase --abort
```

## Undoing Changes

### Discard Unstaged Changes
```bash
git checkout -- <file-name>
git restore <file-name>
```

### Discard All Unstaged Changes
```bash
git checkout -- .
git restore .
```

### Unstage Changes
```bash
git reset <file-name>
git reset HEAD <file-name>
```

### Undo Last Commit (Keep Changes)
```bash
git reset --soft HEAD~1
```

### Undo Last Commit (Discard Changes)
```bash
git reset --hard HEAD~1
```

### Revert Commit (Creates New Commit)
```bash
git revert <commit-hash>
git revert HEAD
```

### Amend Last Commit
```bash
git commit --amend
git commit --amend --no-edit  # Keep commit message
```

## Stashing

### Stash Changes
```bash
git stash
git stash save "message"
```

### List Stashes
```bash
git stash list
```

### Apply Stash
```bash
git stash apply
git stash apply stash@{0}
```

### Pop Stash (Apply and Remove)
```bash
git stash pop
git stash pop stash@{0}
```

### Drop Stash
```bash
git stash drop stash@{0}
```

### Clear All Stashes
```bash
git stash clear
```

## Tags

### Create Tag
```bash
# Lightweight tag
git tag <tag-name>

# Annotated tag
git tag -a <tag-name> -m "message"
```

### List Tags
```bash
git tag
git tag -l "v*"
```

### Show Tag
```bash
git show <tag-name>
```

### Push Tag
```bash
# Push specific tag
git push origin <tag-name>

# Push all tags
git push --tags
```

### Delete Tag
```bash
# Delete local tag
git tag -d <tag-name>

# Delete remote tag
git push origin --delete <tag-name>
```

## Searching & Finding

### Search Commit Messages
```bash
git log --grep="search-term"
```

### Search Code Changes
```bash
git log -S "search-term"
```

### Find Commit by Author
```bash
git log --author="author-name"
```

### Find Commits by Date
```bash
git log --since="2026-01-01" --until="2026-12-31"
git log --since="2 weeks ago"
```

## Useful Shortcuts & Tips

### View Diff Between Branches
```bash
git diff <branch1> <branch2>
```

### View Files Changed in Commit
```bash
git diff-tree --no-commit-id --name-only -r <commit-hash>
git show --name-only <commit-hash>
```

### Clean Untracked Files
```bash
# Preview what will be deleted
git clean -fd --dry-run

# Delete untracked files and directories
git clean -fd
```

### Create Alias
```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
```

### Check Git Reflog
```bash
git reflog
```

## Emergency Commands

### Recover Deleted Branch
```bash
git reflog
git checkout -b <branch-name> <commit-hash>
```

### Recover Deleted Commits
```bash
git reflog
git reset --hard <commit-hash>
```

### Completely Reset to Remote
```bash
git fetch origin
git reset --hard origin/main
```

## Workflow Example

```bash
# 1. Clone repository
git clone https://github.com/user/repo.git
cd repo

# 2. Create new branch
git checkout -b feature/new-feature

# 3. Make changes
# ... edit files ...

# 4. Stage and commit
git add .
git commit -m "Add new feature"

# 5. Push to remote
git push -u origin feature/new-feature

# 6. Create pull request on GitHub

# 7. Switch back to main
git checkout main

# 8. Pull latest changes
git pull origin main

# 9. Merge feature branch
git merge feature/new-feature

# 10. Push merged changes
git push origin main

# 11. Delete feature branch
git branch -d feature/new-feature
git push origin --delete feature/new-feature
```

---

## Quick Reference Card

| Task | Command |
|------|---------|
| Clone repo | `git clone <url>` |
| Check status | `git status` |
| Stage all | `git add .` |
| Commit | `git commit -m "message"` |
| Push | `git push` |
| Pull | `git pull` |
| Create branch | `git checkout -b <branch>` |
| Switch branch | `git checkout <branch>` |
| Merge branch | `git merge <branch>` |
| View history | `git log --oneline` |
| Undo last commit | `git reset --soft HEAD~1` |
| Stash changes | `git stash` |
| Pop stash | `git stash pop` |

---

## Additional Resources

- [Official Git Documentation](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)
- [Atlassian Git Tutorial](https://www.atlassian.com/git/tutorials)
- [Interactive Git Learning](https://learngitbranching.js.org/)
