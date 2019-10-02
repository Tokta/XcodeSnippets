#!/bin/bash
echo "Change directory to snippets repository"
cd /Users/alessio/Documents/GitHub/XCodeSnippets
echo "Monitoring snippets changes..."
fswatch -0 /Users/alessio/Documents/GitHub/XCodeSnippets/CodeSnippets | xargs -0 -n 1 bash /Users/alessio/Documents/GitHub/XCodeSnippets/auto_commit_push.sh
