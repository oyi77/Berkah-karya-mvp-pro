# Manual Deploy Steps (If Auto-Deploy Fails)

## 🚨 Issue: Page 404 After Git Push

### Root Cause:
- Netlify auto-deploy might have cached old build
- Next.js plugin might not detect new dynamic routes
- Environment variables not set

---

## ✅ Solution: Manual Trigger Deploy

### Step 1: Clear Cache & Redeploy
1. Go to: https://app.netlify.com/sites/berkahkarya/deploys
2. Click **"Trigger deploy"** dropdown (top right)
3. Select **"Clear cache and deploy site"**
4. Wait 3-5 minutes for build to complete

### Step 2: Verify Environment Variables
1. Go to: https://app.netlify.com/sites/berkahkarya/settings/deploys#environment
2. Ensure these exist:
   ```
   META_PIXEL_ID=771021905629860
   META_CAPI_ACCESS_TOKEN=EAAJxIW8ZC3KsBRA2FCAeMLs1BKQcQYmdCRCaVnnTrjZArCKhjNxDnbJUuvIeTKKvjRzjRwGS3l0cmZBKIYEQKBGZCIcZC5PI0S2mlcZBiS3HEBrZAJBRNP7WRCQYPEa7jEpPTRuf4YytZCcFy1c92naIbZAH5Y076YX13IvcjzFhptqJVRvc0ouerFXYDe2uR7v7ZCygZDZD
   NEXT_PUBLIC_GA_MEASUREMENT_ID=G-V9C14XZ9SG
   ```
3. If missing, click **"New variable"** and add them
4. Click **"Save"**
5. Trigger redeploy (Step 1)

### Step 3: Check Build Log
1. While deploy is running, click the deploy in progress
2. Check "Deploy log" for errors
3. Look for:
   ```
   ✓ Generating static pages (XX/XX)
   ✓ Finalizing page optimization
   ```
4. Should see: `/id/digital-products/ebook-suami-sejati` in generated pages

### Step 4: Verify Live URL
After deploy completes:
```bash
curl -I https://berkahkarya.org/id/digital-products/ebook-suami-sejati
```
Should return: `HTTP/2 200`

---

## 🔍 Debugging Checklist

### If still 404:
- [ ] Check Netlify build succeeded (no red X)
- [ ] Verify file exists in deploy preview: 
      `https://deploy-preview-XXX--berkahkarya.netlify.app/id/digital-products/ebook-suami-sejati`
- [ ] Clear your browser cache (Ctrl+Shift+R)
- [ ] Try incognito window
- [ ] Check DNS propagation: https://dnschecker.org/#A/berkahkarya.org

### If build fails:
- [ ] Check build log for syntax errors
- [ ] Verify `npm run build` works locally
- [ ] Check Node version matches (20.x)
- [ ] Ensure all dependencies in package.json

---

## 📊 Expected Build Output

In build log, you should see:
```
Route (pages)                                      Size     First Load JS
├ ● /[locale]/digital-products                     5.95 kB         119 kB
├   └ css/0e40a336fa5efb19.css                     2.15 kB
├   ├ /id/digital-products
├   └ /en/digital-products
├ ● /[locale]/digital-products/ebook-suami-sejati  XXXXX kB        XXX kB   <-- THIS!
├   ├ /id/digital-products/ebook-suami-sejati
├   └ /en/digital-products/ebook-suami-sejati
```

---

## 🆘 Emergency: Deploy from Local

If Netlify keeps failing, deploy from local machine:

```bash
# Install Netlify CLI
npm install -g netlify-cli

# Login
netlify login

# Link to site
cd /path/to/Berkah-karya-mvp-pro
netlify link

# Deploy manually
netlify deploy --prod

# Follow prompts:
# Publish directory: .next
```

---

## ✅ Success Indicators

### URL Returns 200:
```bash
curl -I https://berkahkarya.org/id/digital-products/ebook-suami-sejati
# HTTP/2 200 ✓
```

### Page Content Loads:
```bash
curl -s https://berkahkarya.org/id/digital-products/ebook-suami-sejati | grep "Ebook Suami Sejati"
# Should return: title or heading with "Ebook Suami Sejati"
```

### Tracking Fires:
1. Open page in browser
2. Open DevTools → Network
3. Filter: `fbevents` or `track-capi`
4. Should see requests firing

### Product Card Shows:
```bash
curl -s https://berkahkarya.org/id/digital-products | grep "Ebook Suami Sejati"
# Should return: card HTML with product name
```

---

## 📞 Get Help

If all else fails:
1. Check Netlify Community: https://answers.netlify.com/
2. Open support ticket: https://app.netlify.com/support
3. Check Next.js plugin issues: https://github.com/netlify/netlify-plugin-nextjs/issues

---

**Last Resort:** Rollback to previous deploy:
1. Go to deploys page
2. Find last working deploy
3. Click "..." → "Publish deploy"
