#!/usr/bin/env bash

set -o nounset
set -o errexit
trap 'echo "Aborting due to errexit on line $LINENO. Exit code: $?" >&2' ERR
set -o errtrace
set -o pipefail

# git-infer
mkdir temp
(
  cd temp
  git init
  touch a
  git add a
  ../../git-infer
  test "$(git log --oneline | wc -l)" == 1
  test "$(git log --pretty=%s -1)" == "Add a"
)
rm -fr temp

# git-infer -a
mkdir temp
(
  cd temp
  git init
  touch a
  git add -N a
  ../../git-infer -a
  test "$(git log --oneline | wc -l)" == 1
  test "$(git log --pretty=%s -1)" == "Add a"
)
rm -fr temp

# git-infer -A
mkdir temp
(
  cd temp
  git init
  touch a
  ../../git-infer -A
  test "$(git log --oneline | wc -l)" == 1
  test "$(git log --pretty=%s -1)" == "Add a"
)
rm -fr temp

# git-infer, filename with spaces
mkdir temp
(
  cd temp
  git init
  touch "this filename has spaces"
  git add "this filename has spaces"
  ../../git-infer
  test "$(git log --oneline | wc -l)" == 1
  test "$(git log --pretty=%s -1)" == 'Add "this filename has spaces"'
)
rm -fr temp

# git-infer -a, filename with spaces
mkdir temp
(
  cd temp
  git init
  touch "this filename has spaces"
  git add -N "this filename has spaces"
  ../../git-infer -a
  test "$(git log --oneline | wc -l)" == 1
  test "$(git log --pretty=%s -1)" == 'Add "this filename has spaces"'
)
rm -fr temp

# git-infer -A, filename with spaces
mkdir temp
(
  cd temp
  git init
  touch "this filename has spaces"
  ../../git-infer -A
  test "$(git log --oneline | wc -l)" == 1
  test "$(git log --pretty=%s -1)" == 'Add "this filename has spaces"'
)
rm -fr temp

# update file
mkdir temp
(
  cd temp
  git init
  touch a
  git add a
  ../../git-infer
  test "$(git log --oneline | wc -l)" == 1
  test "$(git log --pretty=%s -1)" == "Add a"
  echo foo >> a
  git add a
  ../../git-infer
  test "$(git log --oneline | wc -l)" == 2
  test "$(git log --pretty=%s -1)" == "Update a"
)
rm -fr temp

# update file with -a
mkdir temp
(
  cd temp
  git init
  touch a
  git add a
  ../../git-infer
  test "$(git log --oneline | wc -l)" == 1
  test "$(git log --pretty=%s -1)" == "Add a"
  echo foo >> a
  ../../git-infer -a
  test "$(git log --oneline | wc -l)" == 2
  test "$(git log --pretty=%s -1)" == "Update a"
)
rm -fr temp

# delete file
mkdir temp
(
  cd temp
  git init
  touch a
  git add a
  ../../git-infer
  test "$(git log --oneline | wc -l)" == 1
  test "$(git log --pretty=%s -1)" == "Add a"
  rm a
  git add a
  ../../git-infer
  test "$(git log --oneline | wc -l)" == 2
  test "$(git log --pretty=%s -1)" == "Delete a"
)
rm -fr temp

# delete file with -a
mkdir temp
(
  cd temp
  git init
  touch a
  git add a
  ../../git-infer
  test "$(git log --oneline | wc -l)" == 1
  test "$(git log --pretty=%s -1)" == "Add a"
  rm a
  ../../git-infer -a
  test "$(git log --oneline | wc -l)" == 2
  test "$(git log --pretty=%s -1)" == "Delete a"
)
rm -fr temp
