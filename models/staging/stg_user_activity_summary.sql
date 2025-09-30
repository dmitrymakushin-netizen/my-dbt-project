{{ config(materialized='view') }}

select
  -- id_player в исходнике Int64 → приводим к UInt64 (или оставь просто id_player, если не нужно)
  toUInt64(id_player)           as id_player,
  nullIf(trim(country), '')     as country,
  toFloat64(sum_deposits)       as sum_deposits
from {{ source('raw', 'UserActivitySummary') }}
