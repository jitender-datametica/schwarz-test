CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_plan_year_client_itemgroup_2 AS
SELECT PM.plan_id,
 PM.indicator_id,
 PM.client_id,
 PM.itemgroup_int_id,
 PM.cy,
  CASE
  WHEN PM.indicator_id IN (200, 201, 202, 607, 700, 900)
  THEN PM.val_plan_year
  ELSE PM.val_plan_year / CRY.rate_currency_exchange
  END AS val_plan,
 PM.pct_plan_year AS pct_plan,
 PM.dat_dayend,
 CRY.currency_iso_cd
FROM ldl_p_lew_core_ac.v_wawi_plan_year_2 AS PM_2
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON PM.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
WHERE PM.wh_loc_sid IS NULL
 AND PM.orig_store_nr IS NULL
 AND PM.itemgroup_int_id IS NOT NULL;