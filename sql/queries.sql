-- ================================================================================
-- CloudWalk Operational Intelligence Analysis - Essential SQL Queries
-- Author: Rodrigo
-- Date: October 2025
-- Analysis Period: Q1 2025 (January - March 2025)
-- ================================================================================

-- Note: These queries are designed for PostgreSQL/BigQuery syntax
-- Adjust date functions and syntax as needed for your specific database

-- ================================================================================
-- TABLE MAPPING AND DATA SOURCE
-- ================================================================================
--
-- SOURCE DATA FILE: data/operational_intelligence_transactions_db.csv
--
-- TABLE SCHEMA (PostgreSQL/BigQuery):
--   Table Name: transactions
--   
--   Column Mapping from CSV:
--   - day                    DATE          Transaction date
--   - entity                 VARCHAR       Entity type: 'PF' (Individual) or 'PJ' (Business)
--   - product                VARCHAR       Product type: 'pix', 'pos', 'tap', etc.
--   - price_tier             VARCHAR       Pricing tier: 'normal', 'intermediary', 'aggressive', 'domination'
--   - anticipation_method    VARCHAR       Settlement method: 'Pix', 'D1Anticipation', 'D0', 'Nitro', 'BankSlip', etc.
--   - nitro_or_d0            VARCHAR       Binary flag for instant settlement
--   - payment_method         VARCHAR       Payment method: 'credit', 'debit', 'uninformed', etc.
--   - installments           INTEGER       Number of installments (1 = single payment)
--   - amount_transacted      DECIMAL       Total payment volume for the day (R$)
--   - quantity_transactions  INTEGER       Number of transactions for the day
--   - quantitu_of_merchants  INTEGER       Number of unique merchants transacting on this day
--                                          NOTE: Column name has typo ("quantitu" instead of "quantity")
--
-- IMPORTANT DATA LINEAGE:
--   - This is AGGREGATED daily data, not transaction-level data
--   - Each row represents one day's aggregate metrics for a specific combination of dimensions
--   - The CSV contains 62,030 rows representing different day × dimension combinations
--
-- ETL PROCESS (if loading CSV into database):
--   1. Load CSV into staging table
--   2. Rename column: quantitu_of_merchants → quantity_of_merchants (fix typo)
--   3. Convert day to DATE type
--   4. Create final transactions table with appropriate data types
--
-- EXAMPLE TABLE CREATION (PostgreSQL):
--   CREATE TABLE transactions (
--       day DATE NOT NULL,
--       entity VARCHAR(10),
--       product VARCHAR(50),
--       price_tier VARCHAR(20),
--       anticipation_method VARCHAR(50),
--       nitro_or_d0 VARCHAR(10),
--       payment_method VARCHAR(50),
--       installments INTEGER,
--       amount_transacted DECIMAL(15,2),
--       quantity_transactions INTEGER,
--       quantity_of_merchants INTEGER
--   );
--
-- PERFORMANCE NOTES:
--   - Queries use window functions (OVER()) for percentage calculations - efficient on modern databases
--   - Date functions (DATE_TRUNC, EXTRACT) may vary by database - adjust as needed
--   - Consider adding indexes on: day, entity, product, anticipation_method for faster filtering
--   - Estimated execution time: 1-5 seconds per query on dataset of this size (62K rows)
--
-- MERCHANT COUNT AGGREGATION CLARIFICATION:
--   ⚠️ CRITICAL: The quantity_of_merchants field represents "merchant-days" not unique merchants.
--   
--   - SUM(quantity_of_merchants) = Total transacting-merchant-days (not unique merchant count)
--   - If a merchant transacts on 5 days, they count as 5 in the sum
--   - To get unique merchant count, you would need merchant_id field (not available in this dataset)
--   
--   EXAMPLE:
--     Day 1: 100 merchants
--     Day 2: 100 merchants (50 same as Day 1, 50 new)
--     SUM(quantity_of_merchants) = 200 (merchant-days)
--     Actual unique merchants = 150 (but cannot calculate without merchant_id)
--
--   RECOMMENDATION: Interpret merchant metrics as "activity level" not "unique count"
--   - Use for trend analysis (more merchant-days = more activity)
--   - Do not use for customer acquisition metrics (requires unique merchant_id)

-- ================================================================================
-- FINDING #1: PF SEGMENT + WEEKEND MARKET CAPTURE
-- ================================================================================

-- 1.1 PF vs PJ Segment Analysis (Entity Performance)
-- NOTE: total_merchants represents transacting-merchant-days, not unique merchant count
SELECT 
    entity,
    SUM(amount_transacted) as tpv,
    SUM(quantity_transactions) as total_transactions,
    SUM(quantity_of_merchants) as total_merchant_days,  -- ⚠️ See MERCHANT COUNT AGGREGATION CLARIFICATION above
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
    'Total Merchant-Days',  -- ⚠️ This is transacting-merchant-days, not unique merchant count
    TO_CHAR(SUM(quantity_of_merchants), 'FM999,999,999')  -- See MERCHANT COUNT AGGREGATION CLARIFICATION in header
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
-- DATA LINEAGE AND EXECUTION NOTES
-- ================================================================================
--
-- EXECUTION WORKFLOW:
--   1. Load CSV into database (see TABLE MAPPING section above)
--   2. Verify data types and fix column name typo (quantitu_of_merchants)
--   3. Run queries in order (findings 1-3, then supporting queries)
--   4. Export results to match README.md analysis
--
-- VALIDATION QUERIES:
--   - Run "Complete Q1 2025 Summary" query first to verify data load
--   - Expected total TPV: ~R$ 19.2B (check README.md for exact figure)
--   - Expected date range: 2025-01-01 to 2025-03-31 (Q1 2025)
--
-- REPRODUCIBILITY:
--   - All queries are deterministic (no random sampling)
--   - Results should match README.md calculations exactly
--   - If discrepancies found, check: date filters, aggregation method, null handling
--
-- PERFORMANCE OPTIMIZATION (if running on large database):
--   - Create indexes: CREATE INDEX idx_day ON transactions(day);
--   - Create indexes: CREATE INDEX idx_entity ON transactions(entity);
--   - Create indexes: CREATE INDEX idx_product ON transactions(product);
--   - Consider partitioning by month if table grows large
--
-- ALTERNATIVE IMPLEMENTATIONS:
--   - These queries can be adapted for pandas/Python: Use GROUP BY, pivot tables
--   - For Excel: Use pivot tables with similar grouping logic
--   - For BigQuery: Queries should run as-is with minimal modification
--
-- ================================================================================
-- END OF ESSENTIAL QUERIES
-- ================================================================================
-- Total: 12 strategic queries supporting 3 findings + business questions
-- Execution Time Estimate: 5-15 seconds total (depending on database size and indexing)
-- ================================================================================
