#!/bin/zsh
echo "something changed.."
NOW=$(date +"%d-%m-%Y-%T")
git add .
echo "changes staged"
git commit -m "auto commit, date: $NOW" $1
echo "new commit"
git push origin master
echo "Pushed new snippets to GitHub"
echo "Monitoring snippets changes..."
