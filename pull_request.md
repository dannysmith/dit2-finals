# Git Pull Request
## Create the branch on gitHub
```
git push --set-upstream origin DITA-9_Course_Search
```

## Hub Gem
Install the Hub gem which allows us to run extra commands on github.
```
gem install hub
```
The code below will open the github page for the current repo that is being worked on. 
```
hub.browse
```

## Create the pull request
The commit message is used as the name of the branch page.
```
hub pull-request -b master -m 'DITA-9_Course_Search'
```

## Rebasing commits
```
git rebase -i [commit hash]
```

## Cherry pick a commit
Grab an action from another branch and apply to current branch using the hash of the commit
```
git cherry-pick [commit hash]
```

## Changing text editor to sublime rather from Vim
```
git config --global core.editor "'c:/program files/sublime text 2/sublime_text.exe' -w"
```