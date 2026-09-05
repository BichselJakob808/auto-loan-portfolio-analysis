# National Road Auto Finance — 2024 Credit Risk Dashboard

I wanted a project that looked at risk the way a lender actually has to — not just "which loans are late," but which segments of the portfolio are worth a closer look, and whether the data actually backs that up once you dig in. Real loan-level data isn't something you can just download, so I generated a synthetic 2024 auto-loan portfolio (using Claude Sonnet 5) built to behave like a realistic book of business, then treated it exactly like I would a real one: validate it in SQL first, then build a dashboard that actually answers a question instead of just displaying numbers.

**To be upfront:** this is fictional data. No real customers, no real dealership. The point wasn't to fake a real report — it was to practice the actual workflow of credit risk analysis, from raw loan records to a defensible recommendation.


<img width="1479" height="694" alt="NRAF Dashboard" src="https://github.com/user-attachments/assets/e680ed35-d8bd-4b05-885b-e5482eb14e94" />



## The question I was trying to answer

> Which credit tiers are driving delinquency and charge-off rates, and should underwriting be reviewed within those segments?

Everything in this dashboard exists to answer that one question. Before building anything visual, I wanted to know: is risk actually concentrated in specific tiers, or is it spread out? And if it is concentrated, is that tier big enough to actually matter to the bottom line, or is it just a small, noisy segment?

## Why I validated in SQL before touching Power BI

I didn't want to build charts first and hope the numbers were right. So I ran the portfolio through SQL against PostgreSQL first, calculating things like total funded loans, loan counts by tier, delinquency and charge-off counts by tier, and average APR/credit score/loan term by tier. That gave me a set of numbers I trusted going into Power BI, and it meant that if something in the dashboard looked off later, I had a known-good reference to check it against instead of guessing.

I also used SQL to look at delinquency and charge-off rates across APR bands and debt-to-income bands, not just credit tier — partly to see if tier was actually the right lens, or if something like DTI was a stronger signal hiding underneath it.

## How I calculated the rates, and why it matters

```
Delinquency Rate = Delinquent Loans in Credit Tier / Total Loans in Credit Tier
Charge-Off Rate  = Charged-Off Loans in Credit Tier / Total Loans in Credit Tier
```

The denominator here is deliberate. I used each tier's own loan count, not the whole portfolio, specifically so that a small tier with a handful of bad loans doesn't get unfairly buried next to a huge tier with the same raw count of defaults. Rate, not raw count, is what actually tells you whether a segment is risky — but as I found out, rate alone isn't the whole story either (more on that below).

## What the dashboard actually shows

- Total amount funded, total loans funded, delinquent loan count, charged-off loan count
- Funded amount trend across 2024
- Delinquency rate by credit tier
- Charge-off rate by credit tier
- Slicers for dealership, month, credit tier, and loan term

Clicking into a specific credit tier updates both its funded volume and its risk metrics side by side — the point being that you shouldn't look at a tier's risk rate without also seeing how much of the portfolio that tier actually represents.

## What I found

The 2024 portfolio has 8,500 funded loans totaling roughly $212 million, with 845 delinquent loans and 256 charge-offs overall.

Delinquency rates are clearly highest in the Subprime and Deep Subprime tiers — that part wasn't surprising. What I didn't expect going in: charge-off rates are much more tightly clustered across tiers than delinquency rates are. That's an important distinction, because it means a tier can look alarming on delinquency alone but not actually be the biggest driver of realized losses once you look at charge-offs specifically.

That's the finding I'd push back on if someone jumped straight to "just tighten underwriting on Subprime." A high rate in a small tier can matter less to the business than a moderate rate in a tier that's carrying a lot more loan volume — so before recommending a policy change, I wanted to check exposure, not just rate.

## What I'd actually recommend

Subprime and Deep Subprime are worth a closer look — their delinquency rates justify that much. But I'd stop short of recommending a broad underwriting change until someone confirms those tiers also represent meaningful funded volume and loss exposure, not just a high rate on a small book.

Since charge-off rates don't vary as sharply by tier, I think the more useful next step is looking at loan seasoning, dealership mix, and debt-to-income ratio specifically — those feel more likely to explain the gap between "who goes delinquent" and "who actually gets charged off" than credit tier alone does.

## Dashboard Preview

Add a screenshot of the completed Power BI dashboard here.

## Tools

- **Power BI** — dashboard design, data modeling, DAX measures
- **SQL / PostgreSQL** — validating the portfolio and calculating risk rates before building anything visual
- **Excel / CSV** — source data preparation

## How to Use

1. Open the Power BI dashboard file
2. Use the dealership, month, credit-tier, and term slicers to filter the portfolio
3. Review delinquency and charge-off rates by credit tier
4. Select an individual credit tier to see its funded volume alongside its risk metrics

## Repository Contents

```
├── Question1QRY.sql         # SQL queries for portfolio and credit-risk analysis
├── dashboard-screenshot.png # Power BI dashboard preview
└── README.md                # Project overview and findings
```

---

**Jakob Bichsel**
Aspiring Data Analyst | SQL | Power BI | Portfolio Analytics
