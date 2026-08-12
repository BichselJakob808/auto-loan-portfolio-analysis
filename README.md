# National Road Auto Finance — 2024 Credit Risk Dashboard

An interactive Power BI dashboard analyzing National Road Auto Finance's 2024 funded auto-loan portfolio, with a focus on credit-tier risk, delinquency, and charge-offs. Loan and customer data are fictional, synthetically generated using Claude Sonnet 5, and used to demonstrate hands-on skills in data modeling, risk segmentation, and dashboard design

## Project Objective

This project answers the business question:

> Which credit tiers are driving delinquency and charge-off rates, and should underwriting be reviewed within those segments?

The goal is to give stakeholders a clear view of 2024 portfolio funding and identify where credit risk may warrant further attention.

## Dashboard Features

The dashboard includes:

* Total amount funded
* Total loans funded
* Delinquent loan count
* Charged-off loan count
* Funded amount trend across 2024
* Delinquency rate by credit tier
* Charge-off rate by credit tier
* Interactive slicers for dealership, month, credit tier, and loan term

Users can select a credit tier to see that segment's funded-loan volume and funding amount alongside its risk metrics.

## Tools Used

* Power BI — dashboard design, data modeling, DAX measures, and interactive visuals
* SQL / PostgreSQL — data validation, portfolio analysis, and risk-rate calculations
* Excel / CSV — source data preparation

## SQL Analysis

The SQL analysis was used to validate the portfolio and calculate:

* Total funded loans
* Loan counts by credit tier
* Delinquent and charged-off loan counts by tier
* Delinquency rate by tier
* Charge-off rate by tier
* Share of total delinquencies and charge-offs by tier
* Average APR, amount financed, credit score, and loan term by tier
* Delinquency and charge-off rates across APR and debt-to-income bands

## Core Rate Logic

```
Delinquency Rate =
Delinquent Loans in Credit Tier / Total Loans in Credit Tier

Charge-Off Rate =
Charged-Off Loans in Credit Tier / Total Loans in Credit Tier
```

Using the tier's own loan count as the denominator makes the comparison fair across segments of different sizes.

## Key Findings

* The 2024 portfolio includes 8,500 funded loans and approximately $212 million in funded volume.
* Overall, the portfolio includes 845 delinquent loans and 256 charged-off loans.
* The highest delinquency rates appear in the Subprime and Deep Subprime segments.
* Charge-off rates are more closely clustered across tiers, so underwriting decisions should consider both risk rates and the number of loans in each tier.
* A high-risk rate alone does not necessarily mean a tier is the largest driver of losses; portfolio exposure and total delinquent/charged-off loan volume are also important.

## Business Recommendation

The Subprime and Deep Subprime segments should be reviewed because they show the highest delinquency rates. Before tightening underwriting broadly, the lender should confirm that these tiers also represent meaningful funded-loan volume and loss exposure.

Because charge-off rates are relatively similar across tiers, additional review of loan seasoning, dealership mix, and borrower characteristics such as debt-to-income ratio would help determine whether a policy change is warranted.

## Dashboard Preview

Add a screenshot of the completed Power BI dashboard here.

## How to Use

1. Open the Power BI dashboard file.
2. Use the dealership, month, credit-tier, and term slicers to filter the portfolio.
3. Review delinquency and charge-off rates by credit tier.
4. Select an individual credit tier to view its funded-loan volume and risk metrics.

## Repository Contents

```
├── Question1QRY.sql         # SQL queries for portfolio and credit-risk analysis
├── dashboard-screenshot.png # Power BI dashboard preview
└── README.md                # Project overview and findings
```

## Author

Jake
Aspiring Data Analyst | SQL | Power BI | Portfolio Analytics
