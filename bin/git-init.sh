#!/bin/bash

# Quick init for git projects

git init
echo "*.pyc" >> .gitignore
echo "*.pyo" >> .gitignore
echo "*~" >> .gitignore
echo "*.swp" >> .gitignore
echo "*.egg-info" >> .gitignore
echo ".venv" >> .gitignore
echo ".DS_Store" >> .gitignore
echo "dist/" >> .gitignore
echo ".project" >> .gitignore
echo ".pydevproject" >> .gitignore

git add .gitignore
git commit -m "Initial commit"