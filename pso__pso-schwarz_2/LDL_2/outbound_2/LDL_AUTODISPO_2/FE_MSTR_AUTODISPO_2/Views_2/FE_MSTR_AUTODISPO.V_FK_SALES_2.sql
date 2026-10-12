CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_fk_sales_2 (country_2, source_flag, store, wh, date, itemno, amount
, is_amount_zero, hour_last_sale, promotion, special_placement, v_model, is_trend, forecast_day, tab,
source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS SELECT FQR.country_2,
 0 AS source_flag,
 CAST(FQR.store AS BIGNUMERIC) AS store,
 FQR.wh,
 DATE(FQR.date_) AS date,
 FQR.itemno,
 FQR.amount,
  CASE
  WHEN FQR.amount = 0
  THEN 1
  ELSE 0
  END AS is_amount_zero,
 TIME(CAST(TRIM(FQR.sale_last_time_int) AS TIME)) AS hour_last_sale,
 FQR.promotion,
 FQR.special_placement,
 FQR.v_model,
 FQR.is_trend,
 FD.forecast_day,
 'fqr' AS tab,
 FQR.source_extraction_tmsp,
 FQR.snflk_insert_tmsp,
 FQR.snflk_update_tmsp
FROM ldl_autodispo_core.t_hive_v_forecast_quality_reduced_2 AS FQR
 INNER JOIN ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_forecast_day_2 AS FD ON FQR.country_2 = FD.country_2
WHERE FQR.forecast_day = 1
UNION ALL
SELECT S.country_2,
 1 AS source_flag,
 S.sales_store_nr AS store,
 ST.store_wh AS wh,
 DATE(S.date_) AS date,
 S.sales_item_nr AS itemno,
 S.sales_quantity AS amount,
  CASE
  WHEN S.sales_quantity = 0
  THEN 1
  ELSE 0
  END AS is_amount_zero,
 CAST(NULL AS TIME) AS hour_last_sale,
 CAST(NULL AS BIGNUMERIC) AS promotion,
 CAST(NULL AS BIGNUMERIC) AS special_placement,
 CAST(NULL AS STRING) AS v_model,
 CAST(NULL AS BIGNUMERIC) AS is_trend,
 FD.forecast_day,
 'ora' AS tab,
 S.source_extraction_tmsp,
 S.snflk_insert_tmsp,
 S.snflk_update_tmsp
FROM ldl_autodispo_core.t_oracle_v_fk_sales_2 AS S
 INNER JOIN ldl_autodispo_core.t_oracle_v_dim_store_2 AS ST ON S.sales_store_nr = ST.store_nr AND S.country_2 = ST.country_2
  AND ST.deleted = 0
 INNER JOIN ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_forecast_day_2 AS FD ON S.country_2 = FD.country_2
WHERE S.deleted = 0;