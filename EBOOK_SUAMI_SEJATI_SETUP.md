# Ebook Suami Sejati - Setup & Deploy Guide

## 📁 Files Created

### 1. Landing Page Component
```
pages/[locale]/digital-products/ebook-suami-sejati.tsx
```
- Full landing page dengan framework PPS + PAS + Value Stacking
- Tracking terintegrasi (Pixel, CAPI, GA)
- Bilingual (ID/EN)
- Responsive & accessible

### 2. CAPI Tracking API
```
pages/api/track-capi.ts
```
- Meta Conversions API endpoint
- Server-side event tracking
- IP & User-Agent capture
- SHA256 hashing untuk PII

### 3. Product Data Update
```
data/products.ts
```
- Added "Ebook Suami Sejati" ke dpCatalog
- Showcase muncul di /digital-products

---

## 🔧 Configuration Required

### 1. Environment Variables (.env.local)
```bash
# Meta Pixel & CAPI
META_PIXEL_ID=771021905629860
META_CAPI_ACCESS_TOKEN=your_actual_token_here

# Google Analytics
NEXT_PUBLIC_GA_MEASUREMENT_ID=G-V9C14XZ9SG
```

**How to get Meta CAPI Token:**
1. Go to [Meta Events Manager](https://business.facebook.com/events_manager2)
2. Select your Pixel (771021905629860)
3. Settings → Conversions API → Generate Access Token
4. Copy token ke `.env.local`

---

## 🌐 URLs Structure

### Live URLs:
- **Landing Page:** `https://berkahkarya.org/id/digital-products/ebook-suami-sejati`
- **Showcase:** `https://berkahkarya.org/id/digital-products` (card muncul di catalog)
- **Checkout:** `https://lynk.id/jendralbot/l7qdy174d73d/checkout` (LYNK payment)

### Routes:
- `/id/digital-products/ebook-suami-sejati` - Indonesian landing page
- `/en/digital-products/ebook-suami-sejati` - English landing page

---

## 📊 Tracking Events

### Event Flow:
1. **PageView** - User lands on page
2. **ViewContent** - 25%, 50%, 75% scroll depth
3. **InitiateCheckout** - CTA button clicked
4. **Redirect** - User goes to LYNK checkout

### Tracked Events:
| Event | Trigger | Platforms |
|-------|---------|-----------|
| `PageView` | Page load | Pixel, CAPI, GA4 |
| `ViewContent` | Scroll 25/50/75% | Pixel, CAPI, GA4 |
| `InitiateCheckout` | CTA click | Pixel, CAPI, GA4 |

### Custom Data Sent:
```javascript
{
  content_name: 'ebook-suami-sejati',
  content_category: 'digital_product',
  value: 49000,
  currency: 'IDR',
  cta_section: 'hero' | 'offer' | 'final',
  // + session_id, utm params, etc.
}
```

---

## 🚀 Deploy Steps

### 1. Update .env.local
```bash
cd /home/openclaw/.openclaw/workspace/Berkah-karya-mvp-pro

# Add your Meta CAPI token
nano .env.local
# META_CAPI_ACCESS_TOKEN=YOUR_ACTUAL_TOKEN
```

### 2. Build & Test Locally
```bash
npm run build
npm run dev

# Open browser:
# http://localhost:3000/id/digital-products/ebook-suami-sejati
```

### 3. Test Tracking
1. Open browser DevTools → Network tab
2. Filter by `track-capi` or `fbevents`
3. Click CTA button
4. Check Events Manager:
   - [Meta Events Manager](https://business.facebook.com/events_manager2)
   - Pixel ID: 771021905629860
   - Look for "InitiateCheckout" events
5. Check GA4:
   - [Google Analytics](https://analytics.google.com/)
   - Real-time reports → Events

### 4. Deploy to Netlify
```bash
git add .
git commit -m "feat: add Ebook Suami Sejati landing page with full tracking"
git push origin main

# Netlify auto-deploys from GitHub
# Check: https://app.netlify.com/
```

### 5. Verify Production
```bash
# Wait 2-3 minutes for deploy
curl -I https://berkahkarya.org/id/digital-products/ebook-suami-sejati

# Should return 200 OK
```

---

## ✅ Testing Checklist

### Pre-Deploy:
- [ ] `.env.local` configured with real tokens
- [ ] Build succeeds (`npm run build`)
- [ ] Local dev works (`npm run dev`)
- [ ] Tracking fires in DevTools
- [ ] Meta Events Manager shows test events
- [ ] GA4 Real-time shows test events

### Post-Deploy:
- [ ] Live URL accessible
- [ ] Both `/id/` and `/en/` work
- [ ] Product card visible di `/digital-products`
- [ ] CTA button redirects to LYNK checkout
- [ ] Meta Pixel fires (check with Meta Pixel Helper)
- [ ] CAPI events appear in Events Manager
- [ ] GA4 events appear in Real-time reports
- [ ] Mobile responsive (test on phone)

---

## 🎯 Conversion Tracking

### Expected Event Sequence:
```
1. User clicks FB/TikTok ad → Lands on LP
   Event: PageView (auto)

2. User scrolls 50%+
   Event: ViewContent (scroll_depth: 50)

3. User clicks "Ambil Sekarang" button
   Event: InitiateCheckout (value: 49000)

4. User redirects to LYNK → Completes payment
   Event: Purchase (tracked by LYNK webhook - manual setup)
```

### Manual Purchase Tracking (Optional):
If LYNK sends webhook on successful payment:
```javascript
// In webhook handler (pages/api/lynk-webhook.ts):
fetch('https://graph.facebook.com/v18.0/771021905629860/events', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    data: [{
      event_name: 'Purchase',
      event_time: Math.floor(Date.now() / 1000),
      action_source: 'website',
      event_source_url: 'https://lynk.id/jendralbot/l7qdy174d73d/checkout',
      user_data: {
        em: hashSHA256(email), // if available
        client_ip_address: userIP,
      },
      custom_data: {
        currency: 'IDR',
        value: 49000,
        content_name: 'ebook-suami-sejati',
      }
    }],
    access_token: process.env.META_CAPI_ACCESS_TOKEN,
  }),
});
```

---

## 🎨 Design Tokens

### Colors Used:
- **Background gradient:** `from-slate-900 via-slate-800 to-slate-900`
- **Primary CTA:** `bg-yellow-500 hover:bg-yellow-400` (yellow button)
- **Text:** `text-white` on dark, `text-slate-900` on light
- **Accent:** `text-yellow-400` for highlights

### Fonts:
- Headings: `font-bold` (system font)
- Body: `font-normal` (system font)
- Size: responsive (`text-4xl md:text-6xl` for h1)

### Spacing:
- Section padding: `py-20` (80px vertical)
- Container: `max-w-4xl mx-auto` (centered, 896px max width)
- Gap: `gap-6` (24px) for grids

---

## 🐛 Troubleshooting

### Issue: "track-capi endpoint 404"
**Solution:**
```bash
# Verify API route exists
ls pages/api/track-capi.ts

# Rebuild
npm run build
```

### Issue: "Meta CAPI events not showing"
**Solution:**
1. Check `.env.local` has correct token
2. Verify Pixel ID matches (771021905629860)
3. Check Events Manager → Test Events → look for recent events
4. Enable "Test Mode" in Events Manager for debugging

### Issue: "CORS error on CAPI"
**Solution:**
CAPI calls are server-side → no CORS issue. If seeing CORS:
- Check you're calling `/api/track-capi` (internal)
- NOT calling `graph.facebook.com` directly from client

### Issue: "Page not found after deploy"
**Solution:**
```bash
# Verify getStaticPaths includes [locale]
# Check netlify.toml redirects

# In netlify.toml:
[[redirects]]
  from = "/:locale/digital-products/ebook-suami-sejati"
  to = "/[locale]/digital-products/ebook-suami-sejati"
  status = 200
```

---

## 📈 Performance Optimization

### Already Optimized:
- ✅ Static generation (SSG)
- ✅ Image optimization (Next.js Image)
- ✅ Code splitting (automatic)
- ✅ Font optimization (system fonts)

### Load Time Target:
- **First Contentful Paint:** < 1.5s
- **Largest Contentful Paint:** < 2.5s
- **Time to Interactive:** < 3.5s

### Lighthouse Score Target:
- **Performance:** > 90
- **Accessibility:** > 95
- **Best Practices:** > 90
- **SEO:** > 95

---

## 🔐 Security Notes

### PII Handling:
- ❌ DO NOT send email/phone via client-side pixel
- ✅ Hash PII server-side in CAPI
- ✅ Use SHA256 for hashing

### Environment Variables:
- ❌ NEVER commit `.env.local` to git
- ✅ Add to `.gitignore`
- ✅ Set in Netlify dashboard → Site settings → Environment variables

---

## 📝 Content Updates

### To Update Copy:
Edit file: `pages/[locale]/digital-products/ebook-suami-sejati.tsx`

**Headline:**
Line ~90-98 (Hero section h1)

**Pricing:**
Line ~520-540 (Value Stacking section)

**Bonus List:**
Line ~430-470 (Bonus Stacking section)

### To Add New Product:
1. Copy `ebook-suami-sejati.tsx`
2. Rename to `new-product.tsx`
3. Update content
4. Add to `dpCatalog` in `data/products.ts`

---

## 🎉 Success Metrics

### Week 1 Target:
- 1,000 page views
- 50 InitiateCheckout events (5% CTR)
- 10 purchases (20% conversion)
- ROAS: 3x minimum

### Optimization Points:
1. **If CTR < 3%:** Improve headline/hero
2. **If conversion < 15%:** Reduce friction (pricing, trust)
3. **If ROAS < 2x:** Check ad targeting/creative

---

## 🆘 Support

### Quick Help:
```bash
# View logs
npm run dev | grep -i "error\|track"

# Test tracking
curl -X POST http://localhost:3000/api/track-capi \
  -H "Content-Type: application/json" \
  -d '{"event_name":"PageView","event_time":1234567890}'

# Check build output
cat .next/build-manifest.json | grep ebook-suami-sejati
```

### External Resources:
- [Meta CAPI Docs](https://developers.facebook.com/docs/marketing-api/conversions-api)
- [Next.js Docs](https://nextjs.org/docs)
- [Netlify Deploy Docs](https://docs.netlify.com/)

---

**Created:** 2026-03-30  
**Last Updated:** 2026-03-30  
**Version:** 1.0.0  
**Status:** ✅ Ready for Production
