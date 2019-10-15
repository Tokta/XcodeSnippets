Sometimes we have to delete Xcode and reinstall it again, which could happen. Usually, you do not think about your snippets until you miss it (at least I don't), so to avoid grieve your snippets, it is always better to have a backup somewhere in the cloud.

## How to backup your Xcode snippets

Create a directory inside Dropbox or Google Drive or iCloud:

`mkdir /Users/YOURPROFILENAME/Documents/GitHub/XCodeSnippets`

Move Xcodesnippets folder to your new location:

`mv -v /Users/YOURPROFILENAME/Library/Developer/Xcode/UserData/CodeSnippets /Users/YOURPROFILENAME/Documents/GitHub/XCodeSnippets`

Create an alias for the new folder in the original location (to be able to edit snippets from Xcode):

`ln -s /Users/YOURPROFILENAME/Documents/GitHub/XCodeSnippets "/Users/YOURPROFILENAME/Library/Developer/Xcode/UserData/"`

Done!

## Steps to use GitHub to backup:
If you don't want to waste your cloud space (and borrow some from GitHub) or you just want a more geeky solution, create your folder as before, but you can create the directory wherever you want on your Mac. Now initiate a git repository and connect it remotely to your account here on GitHub:

Install *fswatch*:

`brew install fswatch`

Use the following script to monitor changes in the repository folder:

```
#!/bin/bash
echo "Change directory to snippets repository"
cd /Users/YOURPROFILENAME/Documents/GitHub/XCodeSnippets
echo "Monitoring snippets changes..."
fswatch -0 /Users/YOURPROFILENAME/Documents/GitHub/XCodeSnippets/CodeSnippets | xargs -0 -n 1 bash /Users/YOURPROFILENAME/Documents/GitHub/XCodeSnippets/auto_commit_push.sh
```
**IMPORTANT**:
The shell where you launch the monitor must remain open or the script will stop working!

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
open -a Terminal /Users/YOURPROFILENAME/Documents/GitHub/XCodeSnippets/monitor.sh
```

Create a plist file and put it inside `~/Library/LaunchAgents`:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.YOURPROFILENAME.snippets.sync</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Users/YOURPROFILENAME/Documents/GitHub/XCodeSnippets/monitor_launcher.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
```

From now on, every time you will log in to you Mac a terminal window will pop, with something similar to this:

```
Last login: Tue Oct 15 13:40:09 on console
/Users/YOURPROFILENAME/Documents/GitHub/XCodeSnippets/monitor.sh ; exit;
(base) My-MacBook-Pro:~ YOURPROFILENAME$ /Users/YOURPROFILENAME/Documents/GitHub/XCodeSnippets/monitor.sh ; exit;
Change directory to snippets repository
Monitoring snippets changes...
|
```

At each change inside the folder (add/edit/delete), you will see your snippets automatically backed up on your GitHub.
