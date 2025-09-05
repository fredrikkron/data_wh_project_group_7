# Data warehouse project

- git branch              # List local branches
- git branch -r           # List remote branches
- git branch -a           # List all branches (local + remote)
- git status

🌿 Create a New Branch
- git checkout -b branch-name

🔁 Switch Between Branches
- git checkout branch-name

🔼 Push/Pull a New Branch to GitHub
- git push -u origin branch-name
- git pull origin branch-name


🧬 Merge a Branch into Another (e.g., feature into main)
- git checkout main
- git pull origin main           # Always pull the latest version first
- git checkout main

- git branch -d branch-name      # Safe delete (won't delete if not merged)
- git branch -D branch-name      # Force delete

Requirements

One person installs the necessary packages and creates a requirements file that is pushed to GitHub:
- uv pip freeze > requirements.txt

Other people install the dependencies listed in the requirements file:
- uv pip install -r requirements.txt