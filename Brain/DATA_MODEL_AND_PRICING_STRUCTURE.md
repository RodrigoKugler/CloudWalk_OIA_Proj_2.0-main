# 📊 CloudWalk InfinitePay Data Model & Pricing Structure

**Author:** Rodrigo  
**Date:** October 2025  
**Purpose:** Understanding the complete data structure connecting InfinitePay app, products, price tiers, anticipation methods, and rates

---

## **Executive Summary**

This document connects all the pieces of CloudWalk's InfinitePay data model:

1. **InfinitePay** = The mobile/web application platform
2. **Product** = Payment method type within InfinitePay (tap, pos, link, pix)
3. **Price_Tier** = Merchant pricing strategy/segment (normal, intermediary, aggressive, domination)
4. **Anticipation_Method** = Settlement timing (D1, D0/Nitro, Pix, Bank Slip)
5. **Rates** = Actual transaction fees (shown in app screenshots: 5.99% instant, 11.39% 2x, etc.)

**Key Insight:** The CSV data has `price_tier` (pricing strategy), but the actual rates (percentages) are managed in the app and visible to merchants. Screenshots show these rates for competitive analysis.

---

## **1. Data Model Hierarchy**

```
InfinitePay (Platform/App)
├── Product (Payment Method Type)
│   ├── tap (Tap to Pay on smartphone)
│   ├── pos (Point of Sale terminal)
│   ├── link (Payment Link/digital invoicing)
│   └── pix (PIX instant payments)
│
├── Price_Tier (Merchant Pricing Segment)
│   ├── normal (Standard/default pricing)
│   ├── intermediary (Mid-tier pricing strategy)
│   ├── aggressive (Competitive/volume pricing)
│   └── domination (Premium/high-value merchant pricing)
│
├── Anticipation_Method (Settlement Timing)
│   ├── D1Anticipation (Next-day settlement)
│   ├── D0/Nitro (Instant 6-second settlement)
│   ├── Pix (Instant PIX payment)
│   └── Bank Slip (Traditional boleto)
│
└── Rates (Transaction Fees - %)
    ├── Instant/At Sight: 5.99%
    ├── 2x installments: 11.39%
    ├── 3x installments: 12.49%
    └── ... (up to 12x: 18.79%)
```

---

## **2. Understanding Price_Tier**

### **2.1 What is Price_Tier?**

**Price_Tier** represents CloudWalk's **pricing strategy or merchant segment classification** for transaction fee calculation. It's **not** the actual rate percentage, but rather a **pricing category** that determines what rates a merchant receives.

### **2.2 Price_Tier Values**

Based on Q1 2025 transaction data analysis:

| Price_Tier | Likely Meaning | Characteristics |
|------------|----------------|-----------------|
| **normal** | Standard/default pricing | Most common tier, baseline rates |
| **intermediary** | Mid-tier merchant segment | Moderate volume or mid-value merchants |
| **aggressive** | Competitive pricing strategy | Volume-based or price-sensitive merchants |
| **domination** | Premium/high-value tier | Large merchants or strategic accounts |

### **2.3 How Price_Tier Works**

**InfinitePay's pricing model:**
- Each merchant is assigned a `price_tier` based on:
  - Transaction volume
  - Merchant segment (PF vs PJ)
  - Negotiated contract terms
  - Strategic importance
  - Historical performance

- The `price_tier` determines which **rate table** the merchant sees in the app
- Different `price_tier` values may have **different rate percentages** for the same product/installment combination
- The CSV data shows transactions by `price_tier`, but actual rates are stored in pricing configuration (shown in app)

---

## **3. Product Types in InfinitePay**

### **3.1 Product = Payment Method Type**

#### **tap (InfiniteTap)**
- **Description:** Tap to Pay on smartphone (iPhone/Android)
- **Technology:** NFC contactless payments
- **Use Cases:** Mobile merchants, delivery, events, service providers
- **Hardware:** None required (uses smartphone)

#### **pos (Smart POS)**
- **Description:** Traditional point-of-sale terminal
- **Technology:** Card-present transactions via hardware terminal
- **Use Cases:** Physical retail, restaurants, fixed locations
- **Hardware:** Requires POS terminal device

#### **link (Payment Link)**
- **Description:** Digital payment link/invoice
- **Technology:** Shareable URL or QR code for payment requests
- **Use Cases:** Online sales, remote payments, invoicing
- **Hardware:** None required (digital only)

#### **pix (PIX Payments)**
- **Description:** Brazil's instant payment system
- **Technology:** Central Bank instant payment infrastructure
- **Use Cases:** All payment scenarios (instant settlement)
- **Hardware:** None required (digital)

### **3.2 Product vs Entity**

- **Product** = How the payment is accepted (tap, pos, link, pix)
- **Entity** = Who is accepting (PF = individual, PJ = business)

Example:
- `PF, tap` = Individual merchant using Tap to Pay
- `PJ, pos` = Business account using POS terminal

---

## **4. Anticipation Methods**

### **4.1 Anticipation_Method = Settlement Timing**

#### **D1Anticipation**
- **Settlement:** Next-day (24 hours)
- **Volume:** R$ 12.5B (65.3% of TPV)
- **Most Popular:** Dominant anticipation method

#### **D0/Nitro (nitro_or_d0 = "D0")**
- **Settlement:** Instant (6 seconds per screenshots)
- **Volume:** R$ 4.2B (21.7% of TPV)
- **Branding:** "Nitro" in InfinitePay app

#### **Pix**
- **Settlement:** Instant (seconds)
- **Volume:** R$ 2.4B (12.7% of TPV)
- **Note:** PIX is both a product and anticipation method

#### **---------------------------------------------**
- **Settlement:** Traditional (T+1 to T+3 days)
- **Volume:** Lower volume, specific use cases

### **4.2 Anticipation_Method vs Product**

**Key Distinction:**
- **Product** = How customer pays (tap, pos, link, pix)
- **Anticipation_Method** = When merchant receives money (D1, D0/Nitro, Pix, Bank Slip)

**Example Combinations:**
- `product = pos, anticipation_method = D1Anticipation` = Customer pays with card at POS, merchant receives next day
- `product = link, anticipation_method = D0/Nitro` = Customer pays via payment link, merchant receives in 6 seconds
- `product = pix, anticipation_method = Pix` = Customer pays with PIX, merchant receives instantly

---

## **5. Rates Structure (From Screenshots)**

### **5.1 Actual Transaction Rates**

Based on InfinitePay app screenshots, here are the **actual rates** merchants see:

#### **Instant/At Sight Settlement:**
- **Rate:** **5.99%** of transaction value
- **Settlement Time:** 6 seconds (Nitro)

#### **Installment Rates:**
| Installments | Rate | % Increase vs Instant |
|--------------|------|----------------------|
| At sight     | 5.99% | Baseline            |
| 2x           | 11.39% | +90.3%             |
| 3x           | 12.49% | +108.5%            |
| 4x           | 13.09% | +118.5%            |
| 5x           | 13.79% | +130.2%            |
| 6x           | 14.49% | +141.9%            |
| 7x           | 15.49% | +158.6%            |
| 8x           | 16.09% | +168.6%            |
| 9x           | 16.69% | +178.6%            |
| 10x          | 17.39% | +190.5%            |
| 11x          | 18.39% | +207.0%            |
| 12x          | 18.79% | +213.7%            |

### **5.2 Rate Structure Observations**

#### **From Screenshots:**
- **Same rates** shown for InfiniteTap, Smart POS, and Payment Link
- **Nitro rates** are specifically for instant settlement (6 seconds)
- Rates **progressively increase** with number of installments
- Higher installments = **significantly higher fees** (nearly 4x instant rate at 12x)

#### **Important Notes:**
- **These rates are for "normal" or standard tier** (most common in data)
- Different `price_tier` values may have **different rates** (we need to confirm)
- **Domination tier** merchants likely pay lower rates (volume discounts)
- **Aggressive tier** merchants may pay different rates (competitive pricing)

---

## **6. Connecting Price_Tier to Rates**

### **6.1 Hypothesis: How Price_Tier Affects Rates**

Based on transaction data patterns and typical payment processor pricing:

#### **Normal Tier:**
- **Rates:** Standard rates as shown in screenshots (5.99% instant, etc.)
- **Merchants:** Default tier for most merchants
- **Volume:** Largest transaction volume

#### **Intermediary Tier:**
- **Rates:** Potentially 5-10% discount vs normal tier
- **Merchants:** Mid-volume merchants (neither small nor large)
- **Volume:** Moderate transaction volume

#### **Aggressive Tier:**
- **Rates:** Competitive pricing (potentially 10-20% discount vs normal)
- **Merchants:** Price-sensitive or high-volume merchants
- **Volume:** Significant transaction volume

#### **Domination Tier:**
- **Rates:** Premium pricing with potential volume discounts (potentially 20%+ discount)
- **Merchants:** Strategic large accounts, enterprise merchants
- **Volume:** Lower volume but higher average ticket size

### **6.2 Evidence from Transaction Data**

**Average Ticket by Price_Tier:**
- **Normal:** Lower average tickets (high volume, standard merchants)
- **Domination:** Higher average tickets (lower volume, premium merchants)
- **Aggressive:** Mixed (volume-focused, competitive pricing)
- **Intermediary:** Mid-range (transition tier)

**Pattern Observed:**
- `price_tier = domination` often appears with **higher avg_ticket** values
- `price_tier = normal` appears with **lower avg_ticket** (high volume)
- Suggests **domination** = premium/high-value merchants with better rates

---

## **7. Complete Transaction Flow Example**

### **Example 1: PF Merchant, Tap to Pay, Normal Tier, D0/Nitro**

```
Transaction Details:
- Entity: PF (Individual merchant)
- Product: tap (Tap to Pay)
- Price_Tier: normal (Standard pricing)
- Anticipation_Method: D0/Nitro (Instant settlement)
- Installments: 1 (At sight)
- Payment_Method: credit (Credit card)

Merchant Experience:
1. Customer taps credit card on merchant's iPhone
2. Transaction processed via InfiniteTap
3. Merchant receives payment in 6 seconds (Nitro)
4. Fee charged: 5.99% of transaction (normal tier, instant rate)
5. Net amount: Transaction value - 5.99% fee

Data Recorded:
- product = "tap"
- price_tier = "normal"
- anticipation_method = "D0/Nitro"
- nitro_or_d0 = "D0"
- payment_method = "credit"
- installments = 1
```

### **Example 2: PJ Merchant, POS Terminal, Domination Tier, D1 Anticipation, 12x Installments**

```
Transaction Details:
- Entity: PJ (Business account)
- Product: pos (POS terminal)
- Price_Tier: domination (Premium tier)
- Anticipation_Method: D1Anticipation (Next-day settlement)
- Installments: 12 (12x credit card)
- Payment_Method: credit

Merchant Experience:
1. Customer pays with credit card at POS terminal
2. Transaction processed with 12 installments
3. Merchant receives payment next day (D1)
4. Fee charged: Potentially ~15% (domination tier gets discount vs 18.79% normal)
5. Net amount: Transaction value - discount rate

Data Recorded:
- product = "pos"
- price_tier = "domination"
- anticipation_method = "D1Anticipation"
- nitro_or_d0 = "" (empty, not instant)
- payment_method = "credit"
- installments = 12
```

---

## **8. Key Insights & Relationships**

### **8.1 Price_Tier Distribution**

**Most Common:**
- **Normal tier:** Majority of transactions (standard pricing)
- **Aggressive tier:** Significant volume (competitive pricing strategy)
- **Domination tier:** Lower volume but higher value (premium merchants)
- **Intermediary tier:** Mid-tier segment

### **8.2 Product + Price대 + Anticipation Combinations**

**Most Common Patterns:**
1. `pos + normal + D1Anticipation` = Standard POS with next-day settlement
2. `pix + normal + Pix` = Standard PIX instant payments
3. `tap + normal + D1Anticipation` = Tap to Pay with next-day settlement
4. `link + normal + D0/Nitro` = Payment Link with instant Nitro settlement

**Premium Patterns:**
- `pos + domination + D1Anticipation` = Large merchants, POS, next-day
- `tap + aggressive + D0/Nitro` = Volume merchants, Tap to Pay, instant

### **8.3 Strategic Implications**

**Pricing Strategy:**
- **Normal tier** = Volume play (most transactions)
- **Domination tier** = Value play (premium accounts)
- **Aggressive tier** = Competitive positioning (win market share)
- **Intermediary tier** = Transition/upsell tier

**Revenue Optimization:**
- Different `price_tier` = Different margin profiles
- Higher `price_tier` (domination) = Potentially lower rates but higher LTV
- Lower `price_tier` (normal) = Standard rates, volume-based revenue

---

## **9. Questions for Further Research**

### **9.1 Critical Questions**

1. ❓ **Do different `price_tier` values have different rates?**
   - Does `domination` tier pay lower rates than `normal`?
   - What's the actual rate difference between tiers?

2. ❓ **How are merchants assigned to `price_tier`?**
   - Is it volume-based?
   - Is it negotiated?
   - Is it automated (ML-based)?

3. ❓ **Do rates vary by product type?**
   - Same rates for tap, pos, link (as screenshots suggest)?
   - Or do different products have different rate tables?

4. ❓ **How do `price_tier` and `anticipation_method` interact?**
   - Does instant (Nitro) have different rates per tier?
   - Does D1 have tier-specific rates?

### **9.2 Data Gaps**

**Missing from CSV:**
- Actual rate percentages (we have from screenshots)
- Rate differences by `price_tier` (need to analyze or get access)
- Merchant tier assignment logic

**Available from Screenshots:**
- Standard rates (5.99% instant, etc.)
- Rate structure for installments
- Nitro instant settlement details

---

## **10. Interview Talking Points**

### **10.1 Understanding the Data Model**

**If asked about data structure:**
> "I analyzed the Q1 2025 transaction data and identified the complete data model. InfinitePay is the platform, products are payment methods (tap, pos, link, pix), price tiers represent merchant pricing segments (normal, intermediary, aggressive, domination), and anticipation methods determine settlement timing. The actual rates are configured in the app and I compared them to competitor benchmarks from InfinitePay screenshots."

### **10.2 Price Tier Strategy**

**If asked about pricing strategy:**
> "The data shows four price tiers indicating a sophisticated pricing segmentation model. Normal tier represents the volume play, domination tier targets premium accounts with likely better rates, aggressive tier is competitive positioning, and intermediary appears to be a transition tier. This suggests CloudWalk uses dynamic pricing based on merchant value, volume, and strategic importance."

### **10.3 Competitive Analysis**

**If asked about rates:**
> "From InfinitePay app screenshots, I identified that standard instant settlement is 5.99%, with rates progressively increasing to 18.79% for 12x installments. CloudWalk's STRATUS blockchain infrastructure should enable competitive or superior pricing. The price tier system suggests we can optimize margins by tiering merchants appropriately."

---

## **11. Summary: The Complete Picture**

### **11.1 Data Model**

```
Transaction = {
    entity: PF | PJ,
    product: tap | pos | link | pix,
    price_tier: normal | intermediary | aggressive | domination,
    anticipation_method: D1Anticipation | D0/Nitro | Pix | Bank Slip,
    installments: 1-12,
    payment_method: credit | debit | uninformed,
    → Results in specific rate % applied (from pricing config)
}
```

### **11.2 Key Relationships**

1. **Product × Price_Tier × Anticipation** = Determines rate structure
2. **Installments** = Modifies base rate (higher installments = higher rates)
3. **Entity (PF vs PJ)** = Influences pricing tier assignment
4. **Volume/Value** = Determines price_tier (domination = premium, normal = volume)

### **11.3 What We Know**

✅ **CSV Data:**
- Transaction volumes by product, tier, anticipation method
- Merchant behavior patterns
- Settlement method preferences

✅ **Screenshots:**
- Standard rates (5.99% instant, 18.79% 12x)
- Rate structure and transparency
- Nitro instant settlement details

✅ **Analysis:**
- Price tier = Pricing strategy/merchant segment
- Rates determined by tier + product + anticipation + installments
- Different tiers likely have different rate discounts

### **11.4 What We Need**

❓ **To Complete Picture:**
- Actual rate tables per price_tier
- Merchant tier assignment logic
- Rate differences across tiers
- Pricing strategy documentation

---

**This document provides the complete framework for understanding how InfinitePay's data model connects products, pricing tiers, anticipation methods, and rates - essential context for interview preparation and strategic analysis.**

---

**Last Updated:** October 2025  
**Status:** Complete Framework Understanding  
**Next Steps:** Validate rate differences by price_tier if data becomes available
