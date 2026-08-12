SELECT COUNT(*) AS total_loans
FROM auto_loans;
/*This was where I counted the number of total loans after I imported my data.
I should have had 8500 but I had 15 extra. */

SELECT loan_id, COUNT (*) AS loan_count 
FROM auto_loans
GROUP BY loan_id
HAVING COUNT(*) >1
ORDER BY loan_count DESC;

SELECT *
FROM auto_loans
WHERE loan_id IS NULL;

--I found 15 completely NULL loans and deleted them from my data

DELETE FROM auto_loans
WHERE loan_id IS NULL;

SELECT COUNT(*) AS total_loans
FROM auto_loans;


SELECT COUNT(*) AS missing_loans_ids
FROM auto_loans
WHERE loan_id IS NULL;

-- 1. Portfolio Composition

SELECT credit_tier, COUNT(*) AS total_loans
FROM auto_loans
GROUP BY credit_tier
ORDER BY total_loans DESC;

-- 2. Delinquency by Credit Tier

SELECT credit_tier, COUNT(*) AS total_loans, SUM(delinquent_flag) AS delinquent_loans
FROM auto_loans
GROUP BY credit_tier;


-- 3 Charge-Off by Credit Tier

SELECT credit_tier, COUNT(*) AS total_loans, SUM(charge_off_flag) AS charge_off_loans
FROM auto_loans
GROUP BY credit_tier;

-- 4. Delinquency Rate

SELECT credit_tier, COUNT(*) AS total_loans, SUM(delinquent_flag) AS delinquent_loans,
ROUND(SUM(delinquent_flag):: NUMERIC / COUNT(*)*100,2) AS delinquency_rate
FROM auto_loans
GROUP BY credit_tier
ORDER BY delinquency_rate DESC;

-- 5. Charge-Off rate


SELECT credit_tier, COUNT(*) AS total_loans, SUM(charge_off_flag) AS charge_off_loans,
ROUND(SUM(charge_off_flag):: NUMERIC / COUNT(*)*100,2) AS charge_off_rate
FROM auto_loans
GROUP BY credit_tier
ORDER BY charge_off_rate DESC;

-- 6. Percentage of all Delinquencies

SELECT credit_tier, COUNT(*) AS total_loans, SUM(delinquent_flag) AS delinquent_loans,
ROUND(SUM(delinquent_flag)::NUMERIC / (SELECT SUM(delinquent_flag) FROM auto_loans)*100,2) 
AS pct_of_total_delinquencies
FROM auto_loans
GROUP BY credit_tier
ORDER BY pct_of_total_delinquencies DESC;

-- 7. Percentage of all Charge-offs

SELECT credit_tier, COUNT(*) AS total_loans, SUM(charge_off_flag) AS charge_off_loans,
ROUNd(SUM(delinquent_flag)::NUMERIC/(SELECT SUM(delinquent_flag) FROM auto_loans)*100,2) 
AS pct_of_total_charge_offs
FROM auto_loans
GROUP BY credit_tier
ORDER BY pct_of_total_charge_offs DESC;

-- 8. Finding averages of APR, financed amount, credit score, term

SELECT credit_tier, ROUND(AVG(apr_pct),2) AS avg_apr,ROUND(AVG(amount_financed),2) AS avg_amount_financed,
ROUND(AVG(credit_score),0) AS avg_credit_score,ROUND(AVG(loan_term_months),0) AS avg_term
FROM auto_loans
GROUP BY credit_tier;

-- 9. Delinquency rate by credit tier and Loan status

SELECT credit_tier, loan_status,COUNT(*) AS loan_count
FROM auto_loans
GROUP BY credit_tier, loan_status
ORDER BY credit_tier, loan_status;

-- 10. APR Bands

SELECT
    CASE
        WHEN apr_pct < 6 THEN 'Under 6%'
        WHEN apr_pct < 10 THEN '6-10%'
        WHEN apr_pct < 15 THEN '10-15%'
        WHEN apr_pct < 20 THEN '15-20%'
        ELSE '20%+'
    END AS apr_band,
    COUNT(*) AS total_loans
FROM auto_loans
GROUP BY
    CASE
        WHEN apr_pct < 6 THEN 'Under 6%'
        WHEN apr_pct < 10 THEN '6-10%'
        WHEN apr_pct < 15 THEN '10-15%'
        WHEN apr_pct < 20 THEN '15-20%'
        ELSE '20%+'
    END
ORDER BY apr_band;

--Adding delinquency to APR bands

SELECT
    CASE
        WHEN apr_pct < 6 THEN 'Under 6%'
        WHEN apr_pct < 10 THEN '6-10%'
        WHEN apr_pct < 15 THEN '10-15%'
        WHEN apr_pct < 20 THEN '15-20%'
        ELSE '20%+'
    END AS apr_band,

    COUNT(*) AS total_loans,

    SUM(delinquent_flag) AS delinquent_loans,

    ROUND(
        SUM(delinquent_flag)::NUMERIC / COUNT(*) * 100,
        2
    ) AS delinquency_rate

FROM auto_loans

GROUP BY
    CASE
        WHEN apr_pct < 6 THEN 'Under 6%'
        WHEN apr_pct < 10 THEN '6-10%'
        WHEN apr_pct < 15 THEN '10-15%'
        WHEN apr_pct < 20 THEN '15-20%'
        ELSE '20%+'
    END

ORDER BY
    MIN(apr_pct);

--Adding charge off to APR bands

SELECT
    CASE
        WHEN apr_pct < 6 THEN 'Under 6%'
        WHEN apr_pct < 10 THEN '6-10%'
        WHEN apr_pct < 15 THEN '10-15%'
        WHEN apr_pct < 20 THEN '15-20%'
        ELSE '20%+'
    END AS apr_band,

    COUNT(*) AS total_loans,

    SUM(delinquent_flag) AS delinquent_loans,
    ROUND(SUM(delinquent_flag)::NUMERIC / COUNT(*) * 100,2) AS delinquency_rate,
	SUM(charge_off_flag) AS charge_off_rate, 
	ROUND(SUM(charge_off_flag):: NUMERIC/COUNT(*)*100,2)
	AS charge_off_rate

FROM auto_loans

GROUP BY
    CASE
        WHEN apr_pct < 6 THEN 'Under 6%'
        WHEN apr_pct < 10 THEN '6-10%'
        WHEN apr_pct < 15 THEN '10-15%'
        WHEN apr_pct < 20 THEN '15-20%'
        ELSE '20%+'
    END

ORDER BY
    MIN(apr_pct);


--Credit Tier x APR band

SELECT credit_tier,
CASE
        WHEN apr_pct < 6 THEN 'Under 6%'
        WHEN apr_pct < 10 THEN '6-10%'
        WHEN apr_pct < 15 THEN '10-15%'
        WHEN apr_pct < 20 THEN '15-20%'
        ELSE '20%+'
    END AS apr_band,
	COUNT(*) AS total_loans,
	
ROUND(SUM(delinquent_flag)::NUMERIC/COUNT(*) * 100,2)
AS delinquency_rate,

SUM(charge_off_flag) AS charge_off_loans,
ROUND(SUM(charge_off_flag)::NUMERIC/COUNT(*) *100,2)
AS charge_off_rate

FROM auto_loans
GROUP BY credit_tier,
CASE
        WHEN apr_pct < 6 THEN 'Under 6%'
        WHEN apr_pct < 10 THEN '6-10%'
        WHEN apr_pct < 15 THEN '10-15%'
        WHEN apr_pct < 20 THEN '15-20%'
        ELSE '20%+'
    END
ORDER BY credit_tier, MIN(apr_pct);

--DTI x Credit tier

SELECT credit_tier,
CASE
        WHEN debt_to_income_pct < 20 THEN 'Under 20%'
        WHEN debt_to_income_pct < 30 THEN '20-30%'
        WHEN debt_to_income_pct < 40 THEN '30-40%'
        ELSE '40%+'
    END AS dti_band,
COUNT(*) AS total_loans,

SUM(delinquent_flag) AS delinquent_loans,

ROUND(SUM(delinquent_flag)::NUMERIC / COUNT(*) * 100,2) AS delinquency_rate,
SUM(charge_off_flag) AS charge_off_loans,

ROUND(SUM(charge_off_flag)::NUMERIC / COUNT(*) * 100,2) AS charge_off_rate

FROM auto_loans

GROUP BY
    credit_tier,

    CASE
        WHEN debt_to_income_pct < 20 THEN 'Under 20%'
        WHEN debt_to_income_pct < 30 THEN '20-30%'
        WHEN debt_to_income_pct < 40 THEN '30-40%'
        ELSE '40%+'
    END

ORDER BY credit_tier,MIN(debt_to_income_pct);


