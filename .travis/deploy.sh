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
git remote set-url origin https://${GH_TOKEN}@github.com/$TRAVIS_REPO_SLUG
set -x

## UPLOAD NEW HOSTS
git checkout $TRAVIS_BRANCH

# ----------- STUFF -----------
docker run -v guide_data:/xml -v $PWD/WebGrab/cfgs:/data:ro --rm webgrabplus
docker run -v guide_data:/xml --rm -it  webgrabplus cat /xml/guide.xml > guide.xml
./WebGrab/parse_channels.sh
git add guide.xml spain.m3u8
# ----------- STUFF -----------

git commit -m "$(date +%d-%m-%Y)"

git push origin $TRAVIS_BRANCH
