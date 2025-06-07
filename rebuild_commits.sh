#!/bin/bash

# Rebuild commit history with realistic staged commits (Jan 2025 - Jul 2025)

git checkout -b master || git checkout master
git branch -D fresh-main 2>/dev/null

# Commit dates (fixed, Jan → Jul 2025)
dates=(
  "2025-01-01"
  "2025-01-13"
  "2025-01-25"
  "2025-02-06"
  "2025-02-18"
  "2025-03-02"
  "2025-03-14"
  "2025-03-26"
  "2025-04-07"
  "2025-04-19"
  "2025-05-01"
  "2025-05-13"
  "2025-05-25"
  "2025-06-06"
  "2025-07-01"
)

messages=(
  "Initialize consumer module"
  "Add producer module"
  "Add viewer module"
  "Setup demo environment"
  "Add .gitignore configuration"
  "Introduce adapter.go"
  "Add consumer.go"
  "Add franz_go_adapter.go"
  "Add go.mod"
  "Add go.sum"
  "Add DEMO.md"
  "Add README.md"
  "Include viewer screenshot"
  "Implement roadmap section"
  "Final polish before release"
)

# Files/folders staged per commit
paths=(
  "consumer/"
  "producer/"
  "viewer/"
  "demo/"
  ".gitignore"
  "adapter.go"
  "consumer.go"
  "franz_go_adapter.go"
  "go.mod"
  "go.sum"
  "demo/DEMO.md"
  "README.md"
  "demo/viewer_screenshot.png"
  "rebuild_commits.sh"
  "README.md go.mod consumer/"
)

# Loop through commits
for i in "${!dates[@]}"; do
  base_date="${dates[$i]}"
  msg="${messages[$i]}"
  path="${paths[$i]}"

  # Randomize timestamp
  hour=$((RANDOM % 24))
  minute=$((RANDOM % 60))
  second=$((RANDOM % 60))
  hour=$(printf "%02d" $hour)
  minute=$(printf "%02d" $minute)
  second=$(printf "%02d" $second)

  commit_date="$base_date $hour:$minute:$second"

  echo "Creating commit: $msg ($commit_date) with $path"

  git add $path
  GIT_COMMITTER_DATE="$commit_date" git commit -m "$msg" --date "$commit_date"
done
