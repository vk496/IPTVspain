#!/bin/bash
set -x # Debug
set -e # Exit with nonzero exit code if anything fails

if [ "$TRAVIS_EVENT_TYPE" != "cron" ]; then
    echo "Not Cron. Skipping deploy..."
    exit 0
fi


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

git config --global user.email "$GH_USER_EMAIL"
git config --global user.name "$GH_USER_NAME"

set +x
git remote set-url origin https://${GH_TOKEN}@github.com/vk496/IPTVspian.git
set -x

## UPLOAD NEW HOSTS
git checkout $TRAVIS_BRANCH
docker run --rm -it webgrabplus cat .wg++/guide.xml > guide.xml
git add guide.xml
git commit -m "$(date +%d-%m-%Y)"

git push origin $TRAVIS_BRANCH
