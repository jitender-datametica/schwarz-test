CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_plan_month_store AS
SELECT PM.plan_id,
 PM.indicator_id,
 PM.client_id,
 OSK.st_loc_sid AS store_id,
 PM.cy_month,
  CASE
  WHEN PM.indicator_id IN (200, 201, 202, 607, 700, 900)
  THEN PM.val_plan_month
  ELSE PM.val_plan_month / CRY.rate_currency_exchange
  END AS val_plan,
 PM.pct_plan_month AS pct_plan,
 PM.dat_dayend,
 CRY.currency_iso_cd
FROM ldl_p_lew_core_ac.v_wawi_plan_month AS PM
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_skey AS OSK ON PM.client_id = OSK.client_id AND PM.orig_store_nr = OSK.orig_store_nr
     AND CURRENT_DATE BETWEEN OSK.dat_rec_start AND OSK.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON PM.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
WHERE PM.orig_store_nr IS NOT NULL;