## How to sync Xcode snippets across Macs

Create a directory inside Dropbox or Google Drive or iCloud:
`mkdir /Users/alessio/Documents/GitHub/XCodeSnippets`

Move Xcodesnippets folder to your new location:
`mv -v /Users/alessio/Library/Developer/Xcode/UserData/CodeSnippets /Users/alessio/Documents/GitHub/XCodeSnippets`

Create an alias for the new folder in the original location (to be able to edit snippets from Xcode)
`ln -s /Users/alessio/Documents/GitHub/XCodeSnippets "/Users/alessio/Library/Developer/Xcode/UserData/"`

Done!

## Steps to use Git to sync:
If you don't want to waste your cloud space, and use some of GitHub, or you just want a more geeky solution, create your folder as before, but you can create the directory wherever you want on your Mac.

Install *fswatch*:
`brew install fswatch`

Use the following script to monitor changes in the repository folder:

```
#!/bin/bash
echo "Change directory to snippets repository"
cd /Users/alessio/Documents/GitHub/XCodeSnippets
echo "Monitoring snippets changes..."
fswatch -0 /Users/alessio/Documents/GitHub/XCodeSnippets/CodeSnippets | xargs -0 -n 1 bash /Users/alessio/Documents/GitHub/XCodeSnippets/auto_commit_push.sh
```
**IMPORTANT**:
The shell where you launch the monitor must remain open, or the script will stop working!

Use the following script to automatically push changes to your GitHub:

```
#!/bin/bash
NOW=$(date +"%d-%m-%Y-%T")
git add .
git commit -m "auto commit, date: $NOW" $1
git push origin master
echo "Pushed new snippets to GitHub"
echo "Monitoring snippets changes..."
```

Create script to launch the monitor:

```
#!/bin/bash
open -a Terminal /Users/alessio/Documents/GitHub/XCodeSnippets/monitor.sh
```

Create a plist file and put it inside `~/Library/LaunchAgents` and forget about it:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.alessio.snippets.sync</string>
	<key>ProgramArguments</key>
	<array>
		<string>/Users/alessio/Documents/GitHub/XCodeSnippets/monitor_launcher.sh</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
</dict>
</plist>
```
