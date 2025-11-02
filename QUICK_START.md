# 🚀 Quick Start: Deploy Your GitHub Pages Site in 5 Minutes

## TL;DR - Fastest Way

1. **Go to your GitHub repository → Settings → Pages**
2. **Select "GitHub Actions" as the source**
3. **Click any file → Edit → Add a space → Commit** (this triggers deployment)
4. **Wait 2 minutes → Check Actions tab → Get your URL!**

---

## Detailed Steps (For First Time)

### Step 1: Check Files Exist ✅

Open your repository on GitHub and verify you have:
```
📁 docs/
   ├── index.html
   ├── findings.html
   ├── insights.html
   ├── methodology.html
   ├── styles.css
   ├── script.js
   └── README.md

📁 .github/
   └── workflows/
       └── deploy.yml
```

**Don't have these?** See "Uploading Files" section below.

---

### Step 2: Enable GitHub Pages ⚙️

1. Go to: `https://github.com/YOUR_USERNAME/YOUR_REPO/settings/pages`
   - Replace `YOUR_USERNAME` and `YOUR_REPO` with your actual values
   - Or: Click **Settings** tab → **Pages** (in left sidebar)

2. Under **"Source"**, change dropdown to: **"GitHub Actions"**

3. Click anywhere else (it saves automatically)

✅ Done! GitHub Pages is now enabled.

---

### Step 3: Trigger Deployment 🚀

**Option A: Quick Edit Method** (No Git needed)

1. Go to `.github/workflows/deploy.yml` in your repo
2. Click the **pencil icon** (✏️ Edit)
3. Add a space or newline at the end
4. Scroll down, click **"Commit changes"**
5. This automatically triggers deployment!

**Option B: Use Git** (If you have it installed)

```bash
git add .
git commit -m "Deploy to GitHub Pages"
git push
```

---

### Step 4: Watch It Deploy 👀

1. Click the **"Actions"** tab in your repository
2. You should see "Deploy GitHub Pages" workflow running
3. Wait for green checkmark ✅ (usually 1-2 minutes)

---

### Step 5: Get Your URL 🌐

1. Go to **Settings → Pages** again
2. You'll see: "Your site is live at..."
3. Your URL will be:
   ```
   https://YOUR_USERNAME.github.io/YOUR_REPO_NAME/
   ```

**Example:** If your repo is `rodrigo123/CloudWalk-Analysis`, your site is:
```
https://rodrigo123.github.io/CloudWalk-Analysis/
```

---

## Common Issues & Fixes

### ❌ "Settings tab not visible"
→ Make sure you're the repository owner or have admin access

### ❌ "GitHub Actions option not showing"
→ Make sure `.github/workflows/deploy.yml` file exists first

### ❌ "Workflow failed"
→ Check Actions tab for error details
→ Most common: Missing `docs/` folder or `index.html`

### ❌ "Images not loading"
→ Verify `outputs/visualizations/findings/` folder exists with PNG files
→ Check that image paths in HTML match actual folder structure

### ❌ "404 Not Found"
→ Wait 5-10 minutes (first deployment takes longer)
→ Clear browser cache
→ Double-check the URL is correct (case-sensitive!)

---

## Uploading Files (If Needed)

### Via GitHub Web Interface:

1. **Create folders:**
   - Click "Add file" → "Create new file"
   - Type: `docs/index.html` (creates `docs` folder automatically)
   - Add content, then commit

2. **Upload multiple files:**
   - Navigate to folder (e.g., `docs/`)
   - Click "Add file" → "Upload files"
   - Drag & drop or select files
   - Commit

**Tip:** For many files, it's easier to use Git. But web upload works for small additions.

---

## After Deployment

✅ **Your site updates automatically** every time you push changes!

✅ **No manual steps needed** - just commit and push

✅ **Share the URL** with your team immediately

✅ **Bookmark it** for easy access

---

## Need More Help?

📖 **Full detailed guide:** See `docs/GITHUB_PAGES_SETUP.md`

🔗 **GitHub Docs:** https://docs.github.com/en/pages/getting-started-with-github-pages

💬 **Check Actions tab** for specific error messages

---

## Success Checklist

- [ ] Files are in GitHub repository
- [ ] Settings → Pages → Source = "GitHub Actions"
- [ ] Actions workflow shows green checkmark ✅
- [ ] Site URL works in browser
- [ ] All images load correctly

**Once all checked, you're live! 🎉**

