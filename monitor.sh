#!/bin/zsh
echo "Change directory to snippets repository"
cd /Users/alessio/Documents/GitHub/XCodeSnippets
echo "Monitoring snippets changes..."
fswatch -o /Users/alessio/Documents/GitHub/XCodeSnippets/CodeSnippets | xargs -0 -n 1 zsh /Users/alessio/Documents/GitHub/XCodeSnippets/auto_commit_push.sh
