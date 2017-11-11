#!/usr/bin/env bash
FILES=$(git diff --staged --name-only | sed 's/$/, /g' | xargs echo | sed 's/,$//')
git commit -m "Updated ${FILES}"
