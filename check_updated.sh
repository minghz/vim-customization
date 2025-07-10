#! /bin/zsh -
autoload colors; colors

main_branch_name () {
  possible_names=('main', 'master')

  for name in $possible_names; do
    git rev-parse --verify origin/$name >/dev/null 2>/dev/null

    if [ $? -eq 0 ]; then
      echo $name
      return
    fi
  done

  echo "error" # could be a connection issue, or permission etc.
}

# Loops through the directories and
for dir in */; do
  if [ ! -d $dir/.git/ ]; then
    continue # its not a git directory. skip
  fi

  pushd $dir > /dev/null

  # Check the origin branch name. Also checks git connection works
  main_branch_name=$(main_branch_name)
  if [ "$main_branch_name" = "error" ]; then
    echo $fg[red]Repo update status unknown!$reset_color $dir
    continue # could not obtain branch name because something is wrong
  fi

  # Check if there are new changes to pull
  origin_sha=`git log origin/$main_branch_name -1 --pretty=format:"%H"`
  local_sha=`git log -1 --pretty=format:"%H"`
  git merge-base --is-ancestor $origin_sha $local_sha
  if [ $? -eq 0 ]; then
    echo $fg[green]Repo up-to-date!$reset_color $dir

  else
    echo $fg[yellow]Repo has updates available!$reset_color $dir
  fi

  popd > /dev/null
done


