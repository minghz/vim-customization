# This script goes into every directory and pulls from master if its a git repo
# Was previously used for the pathogen plugin manager. Now simply left here in case I need it again.
find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;
