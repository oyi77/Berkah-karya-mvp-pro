# Netlify Environment Variables Setup

## 🔧 Required Steps

1. **Go to Netlify Dashboard:**
   https://app.netlify.com/sites/berkahkarya/settings/deploys#environment

2. **Add these environment variables:**

```bash
# Meta Pixel & CAPI
META_PIXEL_ID=771021905629860
META_CAPI_ACCESS_TOKEN=EAAJxIW8ZC3KsBRA2FCAeMLs1BKQcQYmdCRCaVnnTrjZArCKhjNxDnbJUuvIeTKKvjRzjRwGS3l0cmZBKIYEQKBGZCIcZC5PI0S2mlcZBiS3HEBrZAJBRNP7WRCQYPEa7jEpPTRuf4YytZCcFy1c92naIbZAH5Y076YX13IvcjzFhptqJVRvc0ouerFXYDe2uR7v7ZCygZDZD

# Google Analytics
NEXT_PUBLIC_GA_MEASUREMENT_ID=G-V9C14XZ9SG

# Admin Panel (already exists, keep it)
BOT_API_URL=https://api-saas.aitradepulse.com
BOT_ADMIN_PASSWORD=BerkahKarya2026!
ADMIN_PANEL_KEY=BerkahKarya2026!
NEXT_PUBLIC_ADMIN_PANEL_KEY=BerkahKarya2026!
```

3. **Click "Save"**

4. **Trigger redeploy:**
   - Go to: https://app.netlify.com/sites/berkahkarya/deploys
   - Click "Trigger deploy" → "Clear cache and deploy site"

---

## ⚠️ IMPORTANT

Environment variables di Netlify **MUST** match `.env.local` (except `.env.local` tidak di-commit ke git).

Netlify akan inject env vars saat build time untuk `NEXT_PUBLIC_*` dan runtime untuk server-side vars.
