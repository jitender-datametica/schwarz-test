CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_hadoop_parameters_2 AS SELECT mandant_id,
  CASE
  WHEN mandant_id = 5
  THEN 'SK'
  ELSE 'DE'
  END AS land_id,
 discount_steps,
 price_ending_threshold,
 discount_count,
 min_discount,
 max_discount,
 min_price AS min_value,
 no_touch_time,
 time_btw_discounts,
 discount_days,
 max_discount_for_max_price,
 max_price_for_max_discount AS price_threshold_for_max_discount,
 discount_ending,
 8 AS promotion_lifecycle,
 valid_to_number_of_days,
 dates_btw_discounts,
 created_at
FROM kfl_nfmd_core.ts_hadoop_parameters_wbs_2
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING) ORDER BY created_at IS NULL DESC, created_at DESC))
  = 1;