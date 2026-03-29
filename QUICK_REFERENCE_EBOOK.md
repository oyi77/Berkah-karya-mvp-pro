# Ebook Suami Sejati - Quick Reference Card

## 🚀 Deploy Command (One-Liner)
```bash
cd ~/.openclaw/workspace/Berkah-karya-mvp-pro && git add . && git commit -m "feat: add Ebook Suami Sejati LP" && git push origin main
```

## 🌐 Live URLs
- **Landing Page:** https://berkahkarya.org/id/digital-products/ebook-suami-sejati
- **Showcase:** https://berkahkarya.org/id/digital-products (card muncul di catalog)
- **Checkout:** https://lynk.id/jendralbot/l7qdy174d73d/checkout

## 📊 Tracking Check (Meta Events Manager)
```bash
# Open this URL after deploy:
https://business.facebook.com/events_manager2/list/pixel/771021905629860/test_events

# Filter by "InitiateCheckout" to see CTA clicks
```

## 🔧 Quick Edit Locations

### Update Headline:
```typescript
// File: pages/[locale]/digital-products/ebook-suami-sejati.tsx
// Line: ~90-98 (h1 inside Hero section)
```

### Update Pricing:
```typescript
// Line: ~520-540 (Value Stacking section)
// Change: Rp 49.000 to new price
```

### Update Bonus:
```typescript
// Line: ~430-470 (Bonus Stacking section)
// Add new bonus items to array
```

## 🧪 Test Tracking Locally
```bash
# 1. Start dev server
npm run dev

# 2. Open browser DevTools → Network tab
# 3. Visit: http://localhost:3000/id/digital-products/ebook-suami-sejati
# 4. Click CTA button
# 5. Look for:
#    - /api/track-capi (status 200)
#    - fbevents.js (Meta Pixel loaded)
#    - gtag/js (GA loaded)
```

## 📱 Mobile Test
```bash
# Get your local IP
ifconfig | grep "inet " | grep -v 127.0.0.1

# Visit on phone:
# http://YOUR_IP:3000/id/digital-products/ebook-suami-sejati
```

## 🎯 Conversion Flow
```
User Flow: Ad → LP → CTA Click → LYNK Checkout → Payment → Success

Tracking:
1. PageView (auto on load)
2. ViewContent (scroll 25/50/75%)
3. InitiateCheckout (CTA click)
4. [Manual] Purchase (LYNK webhook - optional setup)
```

## 🔑 Key Metrics to Monitor

### Day 1-7:
- **Page Views:** 1,000+ target
- **CTR:** 5%+ (50 InitiateCheckout)
- **Conversion:** 20%+ (10 purchases)
- **ROAS:** 3x minimum

### Red Flags:
- CTR < 3% → Fix headline/hero
- Conversion < 15% → Check pricing/trust
- ROAS < 2x → Ad targeting issue

## 🐛 Quick Fixes

### "Page not found"
```bash
npm run build
# Check: .next/server/pages/[locale]/digital-products/
```

### "Tracking not firing"
```bash
# Check .env.local
cat .env.local | grep META_

# Should show:
# META_PIXEL_ID=771021905629860
# META_CAPI_ACCESS_TOKEN=your_token
```

### "LYNK checkout broken"
```bash
# Test URL manually:
curl -I https://lynk.id/jendralbot/l7qdy174d73d/checkout

# Should return: HTTP 200 OK
```

## 📞 Emergency Contacts
- **LYNK Support:** (check LYNK dashboard)
- **Meta Pixel Issues:** [Meta Help Center](https://www.facebook.com/business/help)
- **Netlify Deploy:** [Netlify Status](https://www.netlifystatus.com/)

---

**Pro Tip:** Bookmark this file for quick reference during campaign runs! 🔖
