CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_lead.v_agg_del_qty_str_mth
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT MTH.client_id,
 MTH.item_sid,
 MTH.loc_sid_store,
 MTH.cy_month,
 MTH.busyear,
 CRY.currency_iso_cd,
 MTH.del_qty_nfv_val,
 MTH.del_qty_fv_val,
 MTH.del_qty_brk_alc_val
FROM ldl_p_lew_mart_lead.t_agg_del_qty_str_mth AS MTH
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON MTH.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;