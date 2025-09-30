{{ config(
    materialized='table',
    engine='MergeTree()',
    order_by='(country)'
) }}

select
  coalesce(country, 'Unknown')     as country,   -- <— заменили NULL на 'Unknown'
  countDistinct(id_player)         as users,
  sum(sum_deposits)                as total_deposits,
  round(avg(sum_deposits), 2)      as avg_deposit
from {{ ref('stg_user_activity_summary') }}
group by country
