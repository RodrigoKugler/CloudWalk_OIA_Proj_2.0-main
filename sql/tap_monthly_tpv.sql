-- ================================================================================
-- Monthly TPV Query for TAP Product
-- Simple and straightforward query to analyze monthly Total Payment Volume for TAP
-- ================================================================================

-- Monthly TPV by TAP Product
SELECT 
    year,
    month,
    month_name,
    SUM(amount_transacted) as monthly_tpv,
    SUM(quantity_transactions) as total_transactions,
    SUM(quantity_of_merchants) as total_merchant_days,
    ROUND(SUM(amount_transacted) / NULLIF(SUM(quantity_transactions), 0), 2) as avg_ticket
FROM transactions
WHERE product = 'tap'
GROUP BY year, month, month_name
ORDER BY year, month;

