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

