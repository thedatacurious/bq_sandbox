WITH 
 user_transactions AS (
  SELECT
  'ak212' AS user_id,
  12568002 AS transaction_id,
  'p129' AS product_id,
  '07/03/2021' AS payment_date,
  19.99 AS total_cost
  UNION ALL
  SELECT
  'pk212' AS user_id,
  12568013 AS transaction_id,
  'p123' AS product_id,
  '03/03/2021' AS payment_date,
  84.97 AS total_cost
  UNION ALL
  SELECT
  'lk212' AS user_id,
  12568023 AS transaction_id,
  'p127' AS product_id,
  '03/03/2021' AS payment_date,
  158.97 AS total_cost
    UNION ALL
  SELECT
  'lk212' AS user_id,
  12568003 AS transaction_id,
  'p123' AS product_id,
  '04/03/2021' AS payment_date,
  34.99 AS total_cost
      UNION ALL
  SELECT
  'lk212' AS user_id,
  133458 AS transaction_id,
  'p120' AS product_id,
  '04/03/2021' AS payment_date,
  12.45 AS total_cost
),

paypal_data AS (
  SELECT 
  * FROM 
  UNNEST(
    [
      struct ('07/03/2021' as dt, 'Website Payment' as type,
   'Completed' as status, 'USD' as currency,  19.99 as gross, 12568002 as itemid, 'Credit' as balanceimpact),
   struct ('03/03/2021', 'Website Payment',
   'Completed', 'USD',  84.97, 12568013, 'Credit'),
   struct ('03/03/2021', 'Website Payment',
   'Completed', 'USD',  158.97, 12568023, 'Credit'),
      struct ('04/03/2021', 'Website Payment',
   'Completed', 'USD',  34.99, 12568003, 'Credit')
   ]
   )
)

SELECT
p.dt, p.status, p.gross AS confirmed_revenue_usd
FROM
paypal_data p 
LEFT JOIN 
user_transactions t
ON p.itemid = t.transaction_id
