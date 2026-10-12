CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_hive_fk_forecast_quality_reduced (country, ts, date, itemno,
itemdesc, subgroupno, familyno, store, wh, promotion, hour_last_sale, amount, v_model, pfc, d_pfc, d_min, d_plus,
pfc_before_trend, pfc_model, pfc_day_before, pfc_two_day_before, special_placement, is_trend, archts, is_amount_zero,
forecast_day, pfc_rare_sales) AS SELECT country,
 ts,
 DATE(date_) AS date,
 itemno,
 itemdesc,
 subgroupno,
 familyno,
 store,
 wh,
 promotion,
 TIME(CAST(TRIM(sale_last_time_int) AS TIME)) AS hour_last_sale,
 amount,
 v_model,
 pfc,
 d_pfc,
 d_min,
 d_plus,
 pfc_before_trend,
 pfc_model,
 pfc_day_before,
 pfc_two_day_before,
 special_placement,
 is_trend,
 archts,
  CASE
  WHEN amount = 0
  THEN 1
  ELSE 0
  END AS is_amount_zero,
 forecast_day,
 pfc_rare_sales
FROM ldl_autodispo_core.t_hive_v_forecast_quality_reduced
WHERE forecast_day = 1;