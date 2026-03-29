#!/bin/bash

# Check Netlify Deploy Status
# Usage: ./scripts/check-netlify-deploy.sh

echo "🔍 Checking Netlify deploy status for berkahkarya.org..."
echo ""

# Check if site is accessible
echo "1. Checking main site..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://berkahkarya.org)
if [ "$STATUS" = "200" ]; then
  echo "✅ Main site is UP (HTTP $STATUS)"
else
  echo "❌ Main site returned HTTP $STATUS"
fi

echo ""

# Check if ebook landing page exists
echo "2. Checking Ebook Suami Sejati landing page..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://berkahkarya.org/id/digital-products/ebook-suami-sejati)
if [ "$STATUS" = "200" ]; then
  echo "✅ Landing page is LIVE (HTTP $STATUS)"
  
  # Verify price is correct
  PRICE_CHECK=$(curl -s https://berkahkarya.org/id/digital-products/ebook-suami-sejati | grep -o "Rp 99.000" | head -1)
  if [ ! -z "$PRICE_CHECK" ]; then
    echo "✅ Price is correct: Rp 99.000"
  else
    echo "⚠️  Price might not be updated yet (cache or old deploy)"
  fi
elif [ "$STATUS" = "404" ]; then
  echo "❌ Landing page NOT FOUND (HTTP 404)"
  echo "   This means deploy hasn't completed yet or failed."
  echo ""
  echo "   Next steps:"
  echo "   1. Check: https://app.netlify.com/sites/berkahkarya/deploys"
  echo "   2. Verify latest deploy succeeded (green checkmark)"
  echo "   3. If failed, check build log for errors"
  echo "   4. If stuck, trigger manual redeploy:"
  echo "      - Go to Netlify dashboard"
  echo "      - Click 'Trigger deploy' → 'Clear cache and deploy site'"
else
  echo "❌ Landing page returned HTTP $STATUS"
fi

echo ""

# Check product catalog
echo "3. Checking product catalog..."
CATALOG_CHECK=$(curl -s https://berkahkarya.org/id/digital-products | grep -o "Ebook Suami Sejati")
if [ ! -z "$CATALOG_CHECK" ]; then
  echo "✅ Product card visible in catalog"
else
  echo "⚠️  Product card not found in catalog (might be cache)"
fi

echo ""

# Check if Meta Pixel loads
echo "4. Checking Meta Pixel integration..."
PIXEL_CHECK=$(curl -s https://berkahkarya.org/id/digital-products/ebook-suami-sejati | grep -o "771021905629860")
if [ ! -z "$PIXEL_CHECK" ]; then
  echo "✅ Meta Pixel ID found in page source"
else
  echo "⚠️  Meta Pixel ID not found (might not have loaded yet)"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ "$STATUS" = "200" ]; then
  echo "🎉 DEPLOYMENT SUCCESSFUL!"
  echo ""
  echo "Next steps:"
  echo "1. Test tracking: Open DevTools → Network → Click CTA"
  echo "2. Verify Meta Events Manager shows InitiateCheckout"
  echo "3. Test checkout flow: Click button → verify LYNK redirect"
  echo "4. Launch ad campaign!"
  echo ""
  echo "📊 Links:"
  echo "   Landing Page: https://berkahkarya.org/id/digital-products/ebook-suami-sejati"
  echo "   Meta Events: https://business.facebook.com/events_manager2/list/pixel/771021905629860"
else
  echo "⚠️  DEPLOYMENT INCOMPLETE"
  echo ""
  echo "Action required:"
  echo "1. Go to: https://app.netlify.com/sites/berkahkarya/deploys"
  echo "2. Check latest deploy status"
  echo "3. If failed, check build log"
  echo "4. If succeeded but page 404:"
  echo "   - Clear Netlify cache and redeploy"
  echo "   - Wait 5-10 minutes for CDN propagation"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
