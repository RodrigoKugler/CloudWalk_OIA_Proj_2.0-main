# Step-by-Step Guide: Deploying Your GitHub Pages Site

This guide will walk you through deploying your CloudWalk Q1 2025 presentation site to GitHub Pages, even if you've never done this before.

## Prerequisites

- A GitHub account (free is fine)
- Your project files in a GitHub repository
- Basic familiarity with GitHub's web interface

---

## Step 1: Verify Your Files Are in GitHub

First, make sure your repository has all the necessary files.

### What Should Be in Your Repository:

✅ `docs/` folder with:
- `index.html`
- `findings.html`
- `insights.html`
- `methodology.html`
- `styles.css`
- `script.js`
- `README.md`

✅ `.github/workflows/` folder with:
- `deploy.yml`

✅ `outputs/visualizations/findings/` folder with:
- All your PNG visualization files

### How to Check:

1. Go to your GitHub repository in a web browser
2. Make sure you can see the `docs` folder
3. Click on `docs` and verify you see the HTML files listed above

**If files are missing:** You'll need to upload them first. See "Alternative: Uploading Files" section at the end.

---

## Step 2: Enable GitHub Pages (Simple Method)

GitHub Pages needs to be enabled and configured. Here's how:

### 2.1. Go to Repository Settings

1. In your GitHub repository, click the **"Settings"** tab (at the top of the repository)
   - If you don't see "Settings", make sure you're logged in and have admin access to the repository

2. Scroll down in the left sidebar until you see **"Pages"** (under "Code and automation")
   - Click on **"Pages"**

### 2.2. Configure Pages Source

1. Under **"Source"**, you'll see a dropdown
2. Click the dropdown and select **"GitHub Actions"**
   - DO NOT select "Deploy from a branch" - we're using GitHub Actions
   - If "GitHub Actions" is already selected, you're good to go!

3. The page will save automatically

### 2.3. Verify the Workflow File Exists

1. Go back to your repository main page
2. Click on `.github` folder
3. Click on `workflows` folder
4. Verify you see `deploy.yml` file
   - If it doesn't exist, see "Troubleshooting" section below

---

## Step 3: Trigger the Deployment

GitHub Actions will automatically deploy when you push changes. Here are two ways to trigger it:

### Method A: Make a Small Change (Easiest)

1. Go to your repository on GitHub
2. Click on the `.github/workflows/deploy.yml` file
3. Click the pencil icon (✏️) to edit
4. Add a space or comment (e.g., add `# Deploy` at the top)
5. Scroll down and click **"Commit changes"**
6. This will trigger the deployment automatically

### Method B: Push Any File Change

If you have Git installed on your computer:

```bash
# Navigate to your project folder
cd path/to/your/project

# Add and commit any changes
git add .
git commit -m "Enable GitHub Pages deployment"

# Push to GitHub
git push origin main
```

**Note:** Replace `main` with `master` if your default branch is named `master`.

---

## Step 4: Monitor the Deployment

GitHub Actions will automatically build and deploy your site. Here's how to watch it:

### 4.1. Check Actions Tab

1. In your repository, click the **"Actions"** tab (at the top)
2. You should see a workflow run called "Deploy GitHub Pages"
3. Click on it to see the progress
4. Wait for it to complete (usually 1-2 minutes)

### What You Should See:

- ✅ Yellow dot = In progress
- ✅ Green checkmark = Success!
- ❌ Red X = Error (see Troubleshooting)

### 4.2. Verify Deployment

Once the workflow completes successfully:

1. Go back to **Settings → Pages**
2. You should see a green success message
3. Your site URL will be shown (e.g., `https://yourusername.github.io/repository-name/`)
4. Click the link to view your site!

**First deployment might take 5-10 minutes to become live.** Be patient!

---

## Step 5: Access Your Live Site

Your site will be available at:
```
https://yourusername.github.io/repository-name/
```

For example, if:
- Your GitHub username is `rodrigo123`
- Your repository is named `CloudWalk_OIA_Proj_2.0-main`

Then your site will be at:
```
https://rodrigo123.github.io/CloudWalk_OIA_Proj_2.0-main/
```

**Note:** GitHub automatically creates the URL based on your username and repository name.

---

## Troubleshooting

### Problem: "Settings" tab is not visible

**Solution:** 
- Make sure you're logged into GitHub
- You need to be the repository owner or have admin access
- If it's not your repository, ask the owner to give you admin access

---

### Problem: "GitHub Actions" option is not available in Pages settings

**Solution:**
- Make sure the `.github/workflows/deploy.yml` file exists
- If it doesn't exist, create it:
  1. Click "Add file" → "Create new file"
  2. Path: `.github/workflows/deploy.yml`
  3. Copy the content from the deploy.yml file that was created
  4. Commit the file
  5. Go back to Settings → Pages and try again

---

### Problem: Workflow fails with errors

**Common causes and solutions:**

1. **"No workflow file found"**
   - Make sure `.github/workflows/deploy.yml` exists
   - Check that the file path is exactly correct (including folders)

2. **"Path not found"**
   - Verify the `docs/` folder exists in your repository root
   - Make sure `index.html` is inside the `docs/` folder

3. **"Permission denied"**
   - Go to Settings → Actions → General
   - Under "Workflow permissions", select "Read and write permissions"
   - Click "Save"
   - Re-run the workflow

---

### Problem: Images don't load

**Solution:**
- Check that visualization files exist at: `outputs/visualizations/findings/*.png`
- The HTML files reference them as: `../outputs/visualizations/findings/filename.png`
- Make sure the `outputs` folder is in your repository root (same level as `docs`)

---

### Problem: Site shows "404 Not Found"

**Solution:**
- Wait 5-10 minutes after first deployment
- Clear your browser cache
- Check the Actions tab to ensure deployment succeeded
- Verify the URL is correct (case-sensitive!)

---

## Alternative: If You Need to Upload Files via GitHub Web Interface

If your files aren't in GitHub yet, here's how to add them:

### Upload Individual Files:

1. Go to your repository on GitHub
2. Navigate to the folder where the file should go (or create the folder)
3. Click "Add file" → "Upload files"
4. Drag and drop your files or click "choose your files"
5. Scroll down and click "Commit changes"

### Create Folders:

1. Click "Add file" → "Create new file"
2. Type the folder name, then a `/`, then a filename (e.g., `docs/index.html`)
3. GitHub will automatically create the folder
4. Add your content and commit

**Note:** For many files, using Git on your computer is easier. But this method works for small additions.

---

## Updating Your Site

Every time you make changes:

1. Edit files in the `docs/` folder (or push changes)
2. Commit the changes
3. GitHub Actions will automatically redeploy
4. Your site will update within 1-5 minutes

No need to manually trigger deployment - it happens automatically!

---

## Quick Checklist

Before asking for help, verify:

- [ ] `.github/workflows/deploy.yml` exists
- [ ] `docs/index.html` exists
- [ ] GitHub Pages is set to "GitHub Actions" (not "Deploy from a branch")
- [ ] Actions workflow completed successfully (green checkmark)
- [ ] You've waited 5-10 minutes after deployment
- [ ] You're using the correct URL format

---

## Getting Help

If you're still stuck:

1. **Check the Actions tab** for error messages
2. **Take a screenshot** of any error messages
3. **Check GitHub Status**: https://www.githubstatus.com (to see if GitHub is having issues)
4. **GitHub Docs**: https://docs.github.com/en/pages

---

## Success! 🎉

Once your site is live, you can:
- Share the URL with your team
- Bookmark it for easy access
- Update it anytime by editing files and committing changes

Your presentation is now accessible from anywhere in the world!

