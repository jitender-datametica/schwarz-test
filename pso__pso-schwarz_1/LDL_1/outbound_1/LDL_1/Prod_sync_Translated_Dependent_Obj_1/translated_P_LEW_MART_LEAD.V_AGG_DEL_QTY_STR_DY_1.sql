CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_lead.v_agg_del_qty_str_dy_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT DY.client_id,
 DY.item_sid,
 DY.loc_sid_store,
 DY.dat_formdate,
 DY.cy_month,
 DY.busyear,
 CRY.currency_iso_cd,
 DY.del_qty_nfv_val,
 DY.del_qty_fv_val,
 DY.del_qty_brk_alc_val
FROM ldl_p_lew_mart_lead.t_agg_del_qty_str_dy_1 AS DY
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON DY.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;