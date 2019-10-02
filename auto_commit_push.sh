#!/bin/bash
NOW=$(date +"%d-%m-%Y-%T")
git add .
git commit -m "auto commit, date: $NOW" $1
git push origin master
echo "Pushed new snippets to GitHub"
echo "Monitoring snippets changes..."
