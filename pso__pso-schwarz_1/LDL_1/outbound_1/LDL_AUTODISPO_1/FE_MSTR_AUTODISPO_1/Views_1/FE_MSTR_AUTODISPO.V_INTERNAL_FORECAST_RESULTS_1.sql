CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_internal_forecast_results_1 (country_1, wh, store, itemno,
forecast_date, v_model, date, forecast_day, pfc, promotion, source_flag, source_extraction_tmsp, snflk_insert_tmsp,
snflk_update_tmsp) AS SELECT country_1,
 wh,
 store,
 itemno,
 forecast_date,
 v_model,
 DATE(date_) AS date,
  CASE
  WHEN DATE(date_) >= CURRENT_DATE
  THEN CAST(DATE_DIFF(CURRENT_DATE, DATE(forecast_date), DAY) AS BIGNUMERIC)
  ELSE forecast_day
  END AS forecast_day,
 pfc,
 promotion,
 source_flag,
 source_extraction_tmsp,
 snflk_insert_tmsp,
 snflk_update_tmsp
FROM ldl_autodispo_core.t_internal_forecast_results_1;