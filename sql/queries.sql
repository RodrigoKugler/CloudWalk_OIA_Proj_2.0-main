-- ================================================================================
-- CloudWalk Operational Intelligence Analysis - Essential SQL Queries
-- Author: Rodrigo
-- Date: October 2025
-- Analysis Period: Q1 2025 (January - March 2025)
-- ================================================================================

-- Note: These queries are designed for PostgreSQL/BigQuery syntax
-- Adjust date functions and syntax as needed for your specific database

-- ================================================================================
-- FINDING #1: PF SEGMENT + WEEKEND MARKET CAPTURE
-- ================================================================================

-- 1.1 PF vs PJ Segment Analysis (Entity Performance)
SELECT 
    entity,
    SUM(amount_transacted) as tpv,
    SUM(quantity_transactions) as total_transactions,
    SUM(quantity_of_merchants) as total_merchants,
    ROUND(100.0 * SUM(amount_transacted) / SUM(SUM(amount_transacted)) OVER (), 2) as pct_of_total_tpv
FROM transactions
GROUP BY entity
ORDER BY tpv DESC;


-- 1.2 PF Segment Monthly Trend (Track +2.3pp Growth)
SELECT 
    DATE_TRUNC('month', day) as month,
    entity,
    SUM(amount_transacted) as tpv,
    ROUND(100.0 * SUM(amount_transacted) / SUM(SUM(amount_transacted)) OVER (PARTITION BY DATE_TRUNC('month', day)), 2) as pct_of_month_tpv
FROM transactions
GROUP BY DATE_TRUNC('month', day), entity
ORDER BY month, entity;


-- 1.3 Weekday Performance Analysis (Weekend Opportunity)
-- Note: Adjust DAYOFWEEK function based on your database
SELECT 
    EXTRACT(DOW FROM day) as day_of_week,
    TO_CHAR(day, 'Day') as day_name,
    SUM(amount_transacted) as tpv,
    SUM(quantity_transactions) as total_transactions,
    ROUND(100.0 * SUM(amount_transacted) / SUM(SUM(amount_transacted)) OVER (), 2) as pct_of_total_tpv
FROM transactions
GROUP BY EXTRACT(DOW FROM day), TO_CHAR(day, 'Day')
ORDER BY day_of_week;


-- ================================================================================
-- FINDING #2: PIX STRATEGY → CLOUDWALK INSTANT SUITE
-- ================================================================================

-- 2.1 Product Performance (PIX vs POS vs TAP)
SELECT 
    product,
    SUM(amount_transacted) as tpv,
    SUM(quantity_transactions) as total_transactions,
    ROUND(100.0 * SUM(amount_transacted) / SUM(SUM(amount_transacted)) OVER (), 2) as pct_of_total_tpv
FROM transactions
GROUP BY product
ORDER BY tpv DESC;


-- 2.2 PIX Monthly Trend (Track 13% Stagnation)
SELECT 
    DATE_TRUNC('month', day) as month,
    product,
    SUM(amount_transacted) as tpv,
    ROUND(100.0 * SUM(amount_transacted) / SUM(SUM(amount_transacted)) OVER (PARTITION BY DATE_TRUNC('month', day)), 2) as pct_of_month_tpv
FROM transactions
WHERE product = 'pix'
GROUP BY DATE_TRUNC('month', day), product
ORDER BY month;


-- ================================================================================
-- FINDING #3: ANTICIPATION → WORKING CAPITAL PLATFORM
-- ================================================================================

-- 3.1 Anticipation Method by Entity (87% Usage Validation)
SELECT 
    entity,
    anticipation_method,
    SUM(amount_transacted) as tpv,
    SUM(quantity_transactions) as total_transactions,
    ROUND(100.0 * SUM(amount_transacted) / SUM(SUM(amount_transacted)) OVER (PARTITION BY entity), 2) as pct_of_entity_tpv
FROM transactions
GROUP BY entity, anticipation_method
ORDER BY entity, tpv DESC;


-- 3.2 Total Instant Settlement Usage (D0/Nitro + PIX + D1 Anticipation)
WITH anticipation_summary AS (
    SELECT 
        CASE 
            WHEN anticipation_method IN ('D0', 'Nitro') OR product = 'pix' OR anticipation_method = 'D1Anticipation' THEN 'Instant/Accelerated'
            ELSE 'Traditional'
        END as settlement_type,
        SUM(amount_transacted) as tpv
    FROM transactions
    GROUP BY settlement_type
)
SELECT 
    settlement_type,
    tpv,
    ROUND(100.0 * tpv / SUM(tpv) OVER (), 2) as pct_of_total
FROM anticipation_summary
ORDER BY tpv DESC;


-- ================================================================================
-- SUPPORTING QUERIES (Business Questions Answered)
-- ================================================================================

-- Q1: Which product has more TPV?
SELECT 
    product,
    SUM(amount_transacted) as tpv,
    SUM(quantity_transactions) as total_transactions,
    ROUND(100.0 * SUM(amount_transacted) / SUM(SUM(amount_transacted)) OVER (), 2) as pct_of_total_tpv
FROM transactions
GROUP BY product
ORDER BY tpv DESC;


-- Q3: Which has the biggest average ticket?
SELECT 
    product,
    SUM(amount_transacted) / NULLIF(SUM(quantity_transactions), 0) as avg_ticket,
    SUM(amount_transacted) as total_tpv,
    SUM(quantity_transactions) as total_transactions
FROM transactions
GROUP BY product
ORDER BY avg_ticket DESC;


-- Q4: Which anticipation method is more used by each entity?
SELECT 
    entity,
    anticipation_method,
    SUM(amount_transacted) as tpv,
    ROUND(100.0 * SUM(amount_transacted) / SUM(SUM(amount_transacted)) OVER (PARTITION BY entity), 2) as pct_of_entity_tpv
FROM transactions
GROUP BY entity, anticipation_method
ORDER BY entity, tpv DESC;


-- ================================================================================
-- OVERALL BUSINESS HEALTH
-- ================================================================================

-- Complete Q1 2025 Summary
SELECT 
    'Total TPV' as metric,
    TO_CHAR(SUM(amount_transacted), 'FM999,999,999,999.00') as value
FROM transactions
UNION ALL
SELECT 
    'Total Transactions',
    TO_CHAR(SUM(quantity_transactions), 'FM999,999,999')
FROM transactions
UNION ALL
SELECT 
    'Total Merchants',
    TO_CHAR(SUM(quantity_of_merchants), 'FM999,999,999')
FROM transactions
UNION ALL
SELECT 
    'Overall Avg Ticket',
    TO_CHAR(SUM(amount_transacted) / NULLIF(SUM(quantity_transactions), 0), 'FM999,999.00')
FROM transactions
UNION ALL
SELECT 
    'Date Range',
    TO_CHAR(MIN(day), 'YYYY-MM-DD') || ' to ' || TO_CHAR(MAX(day), 'YYYY-MM-DD')
FROM transactions;


-- ================================================================================
-- GROWTH ANALYSIS
-- ================================================================================

-- Monthly Growth Trend (Track +14.8% Jan→Mar Growth)
WITH monthly_tpv AS (
    SELECT 
        DATE_TRUNC('month', day) as month,
        SUM(amount_transacted) as tpv
    FROM transactions
    GROUP BY DATE_TRUNC('month', day)
)
SELECT 
    month,
    tpv,
    LAG(tpv, 1) OVER (ORDER BY month) as prev_month_tpv,
    ROUND(100.0 * (tpv - LAG(tpv, 1) OVER (ORDER BY month)) / NULLIF(LAG(tpv, 1) OVER (ORDER BY month), 0), 2) as monthly_growth_pct
FROM monthly_tpv
ORDER BY month;


-- ================================================================================
-- END OF ESSENTIAL QUERIES
-- ================================================================================
-- Total: 12 strategic queries supporting 3 findings + business questions
-- ================================================================================
