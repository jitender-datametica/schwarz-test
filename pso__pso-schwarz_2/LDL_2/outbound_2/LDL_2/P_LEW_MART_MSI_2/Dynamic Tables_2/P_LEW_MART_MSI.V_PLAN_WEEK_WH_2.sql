CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_plan_week_wh_2 AS
SELECT PM.plan_id,
 PM.indicator_id,
 PM.client_id,
 WH.src_wh_id AS wh_id,
 PM.cy_week,
  CASE
  WHEN PM.indicator_id IN (200, 201, 202, 607, 700, 900)
  THEN PM.val_plan_week
  ELSE PM.val_plan_week / CRY.rate_currency_exchange
  END AS val_plan,
 PM.pct_plan_week AS pct_plan,
 PM.dat_dayend,
 CRY.currency_iso_cd
FROM ldl_p_lew_core_ac.v_wawi_plan_week_2 AS PM_2
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON PM.client_id = WH.client_id AND PM.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON PM.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
WHERE PM.wh_loc_sid IS NOT NULL
 AND PM.orig_store_nr IS NULL;