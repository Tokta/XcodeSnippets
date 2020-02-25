#!/bin/zsh
echo "Change directory to snippets repository"
cd /Users/alessiosardella/Documents/GitHub/XCodeSnippets
echo "Monitoring snippets changes..."
fswatch -0 /Users/alessiosardella/Documents/GitHub/XCodeSnippets/CodeSnippets | xargs -0 -n1 -I{} zsh /Users/alessiosardella/Documents/GitHub/XCodeSnippets/auto_commit_push.sh
