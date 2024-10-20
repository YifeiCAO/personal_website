#!/bin/bash

# --- Build the site with Quarto ---
quarto render

# Prompt for a commit message
echo "Enter a commit message:"
read commit_message

#remove .git files
#rm -rf .git

# Initialize a new Git repository
#git init


# --- Push source files to the main repository (lukmayer/website.git) ---

# Ensure the current directory is your main project directory (not _site)
# Add and commit changes to the source repo
git add .
git commit -m "$commit_message"

git remote add origin git@github.com:lukmayer/website.git

# Push changes to the main repository (lukmayer/website.git)
# Ensure 'origin' points to the source repo (lukmayer/website.git)
git push -f origin master 


# --- Push rendered files to the GitHub Pages repository (lukmayer.github.io.git) ---

# Navigate to the _site directory (contains the rendered files)
cd _site

# Initialize a new Git repository inside _site if it doesn't exist already
if [ ! -d ".git" ]; then
    git init
    git remote add origin git@github.com:lukmayer/lukmayer.github.io.git
else
    git remote set-url origin git@github.com:lukmayer/lukmayer.github.io.git
fi

# Add and commit the rendered site files
git add .
git commit -m "$commit_message"

# Force push the rendered files to the gh-pages branch of the GitHub Pages repo
git push -f origin master:gh-pages  # Ensure that 'gh-pages' is the correct branch for GitHub Pages

# Navigate back to the root directory of the project
cd ..

# Clean up: Remove the .git directory inside _site to avoid conflicts in the future
#rm -rf _site/.git



