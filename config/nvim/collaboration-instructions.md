# how to add changes
* first pull any changes from the main branch with `git checkout main && git pull`
* create new branch for edit and switch to it with `git checkout -b edit`. the name doesnt have to be 'edit' it can be anything. 
* make changes to nvim-notes.md
* add changes and commit `git add nvim-notes.md && git commit -m "description"`
* push to your branch `git push -u origin edit`. replace 'edit' with the name from the second bulletpoint. 
* you'll need to install github cli with `brew install gh` to use the next command. you can use the website too but tis just easier with the cli. 
* create a pull request `gh pr create --base main --title "title" --fill`. you dont need to add a title if you dont want to. the `--fill` will make the commit message the title.
* i'll approve the pull request and delete the branch
