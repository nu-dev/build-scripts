#!/bin/bash

# Automated deploy script with Circle CI.
# Adapted from https://github.com/nielsenramon/kickster/blob/master/snippets/circle/automated

# Exit if any subcommand fails.
set -e

# Variables
ORIGIN_URL=`git config --get remote.origin.url`
CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d ~/.m2/cache ]; then
    echo "cache not found, will clone repo."
    mkdir ~/.m2/cache
    git clone $ORIGIN_URL ~/.m2/cache/repo
fi

cd ~/.m2/cache/repo

echo "updating repo..."

git pull

echo "building..."

./nu cleanbuild

echo "deploy started..."

echo "switching to gh-pages branch..."
# Checkout gh-pages branch.
if [ `git branch | grep gh-pages` ]
then
  git branch -D gh-pages
fi
git checkout -b gh-pages

# echo "deleting files..."

# Delete raw, nu binary, and config files
# rm -rf nu
# rm -rf config.kg
# rm -rf raw/
rm -rf circle.yml

echo "configuring git..."

# Push to gh-pages.
git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"

echo "pushing to gh-pages..."

git add -fA
git commit --allow-empty -m "[circleci autobuild] $(git log -1 --pretty=%B)"
git push -f $ORIGIN_URL gh-pages

echo "jumping to old branch"
# Move back to previous branch.
git checkout -

echo "deploy ok"

cd $CURR_DIR

exit 0
