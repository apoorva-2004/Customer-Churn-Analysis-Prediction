create database churn;

use churn;

select *from customer_churn;

SHOW COLUMNS FROM customer_churn;

#BASIC KPI QUERIES

#TOTAL CUSTOMERS
select count(CustomerID)
as total_customers
from customer_churn;

#CHURNED CUSTOMERS
select sum(churn) as churned_customers
from customer_churn;

#ACTIVE CUSTOMERS
select count(CustomerID) - sum(churn) as Active_customers
from customer_churn;

#CHURN RATE
SELECT 
ROUND(SUM(Churn)*1.0 / COUNT(CustomerID), 2) AS churn_rate
FROM customer_churn;

#AVG TENURE
select round(avg(Tenure),2) as Avg_tenure
from customer_churn;

#AVG SUPPORT CALLS
select round(avg(`Support Calls`),2) as Avg_support_calls
 from customer_churn;
 
 #AVG PAYMENT DELAY
 select round(avg(`Payment delay`),2) as Avg_payment_delay
 from customer_churn;
 
 #CHURN BY CONTRACT LENGTH
 SELECT 
`Contract Length`,
ROUND(AVG(Churn)*100,2) AS churn_rate_pct
FROM customer_churn
GROUP BY `Contract Length`
ORDER BY churn_rate_pct DESC;

#CHURN BY SUBSCRIPTION TYPE
SELECT 
`Subscription Type`,
ROUND(AVG(Churn)*100,2) AS churn_rate_pct
FROM customer_churn
GROUP BY `Subscription Type`
ORDER BY churn_rate_pct DESC;

#CHURN BY AGE GROUP
SELECT
CASE
    WHEN Age < 25 THEN '<25'
    WHEN Age BETWEEN 25 AND 34 THEN '25-34'
    WHEN Age BETWEEN 35 AND 44 THEN '35-44'
    WHEN Age BETWEEN 45 AND 54 THEN '45-54'
    ELSE '55+'
END AS age_group,
ROUND(AVG(Churn)*100,2) AS churn_rate_pct
FROM customer_churn
GROUP BY age_group
ORDER BY age_group;

#SUPPORT CALL VS CHURN
SELECT 
`Support Calls`,
ROUND(AVG(Churn)*100,2) AS churn_rate_pct
FROM customer_churn
GROUP BY `Support Calls`
ORDER BY `Support Calls`;

#PAYMENT DELAY VS CHURN
SELECT 
`Payment delay`,
ROUND(AVG(Churn)*100,2) AS churn_rate_pct
FROM customer_churn
GROUP BY `Payment delay`
ORDER BY `Payment delay`;

#HIGH-RISK CUSTOMER IDENTIFICATION
SELECT CustomerID, Age, Tenure, `Support Calls`, `Payment delay`,`Contract Length`
FROM customer_churn
WHERE Churn = 1
  AND Tenure < 6
  AND `Support Calls` > 3
  AND `Contract Length` = 'Monthly';

