#!/bin/bash

set -eu

REPO="suzujun/gotest.git"

LAST_COMMIT=$(git log -n 1 --format=%H)
echo "LAST_COMMIT:${LAST_COMMIT}"

# check gh-pages
git fetch
git remote prune origin
echo "end: git fetch"
EXIST_GH_PAGE=`git branch -a | awk "/gh-pages/"`
echo "EXIST_GH_PAGE:${EXIST_GH_PAGE}"

if [ -n "$EXIST_GH_PAGE" ]; then
  echo "> git clone -b gh-pages git@github.com:${REPO} ghpages"
  git clone -b gh-pages "https://${GH_TOKEN}@github.com/${REPO}" ghpages
  cd ghpages
else
  echo "> mkdir -p ghpages"
  mkdir -p ghpages
  cd ghpages
  git init
fi

git config user.name "suzujun"
git config user.email "jsuz.iicot.o@gmail.com"

mkdir -p $CIRCLE_BRANCH
cp ../coverage.html ./$CIRCLE_BRANCH/index.htm
cp ../coverage.txt ./$CIRCLE_BRANCH

git add .

set +e
git commit -m "Deploy to GitHub Pages"
if [ $? -gt 0 ]; then
  echo "nothing to commit."
  exit 0
fi

set -e

echo 'Pushing github pages'
if [ -n "$EXIST_GH_PAGE" ]; then
  #git push --force --quiet origin gh-pages
  git push --force origin gh-pages
else
  #git push --force --quiet "https://${GH_TOKEN}@github.com/${REPO}" master:gh-pages
  git push --force "https://${GH_TOKEN}@github.com/${REPO}" master:gh-pages
fi

echo "CI_PULL_REQUEST=${CI_PULL_REQUEST}"
if [ -z "$CI_PULL_REQUEST" ]; then
  echo "not found to pull request."
  exit 0
fi

# post comment if exist pull request
echo "sending notification"
USERNAME=${CIRCLE_PROJECT_USERNAME}
REPONAME=${CIRCLE_PROJECT_REPONAME}
GHPAGES_URL="https://${USERNAME}.github.com/${REPONAME}/${CIRCLE_BRANCH}"
PULL_REQUEST_NUM=`echo "${CI_PULL_REQUEST}" | grep -o '\d$'`
echo "PULL_REQUEST_NUM=${PULL_REQUEST_NUM}"
APIURL="https://api.github.com/repos/${USERNAME}/${REPONAME}/issues/${PULL_REQUEST_NUM}/comments"
echo "APIURL: _${APIURL}_"
curl -X POST ${APIURL} \
  -H 'accept: application/vnd.github.black-cat-preview+json' \
  -H 'authorization: token ${GH_TOKEN}' \
  -H 'content-type: application/json' \
  -d '{"body":"coverage to ${GHPAGES_URL}"}'
echo "Posted a comment on the pull request."

