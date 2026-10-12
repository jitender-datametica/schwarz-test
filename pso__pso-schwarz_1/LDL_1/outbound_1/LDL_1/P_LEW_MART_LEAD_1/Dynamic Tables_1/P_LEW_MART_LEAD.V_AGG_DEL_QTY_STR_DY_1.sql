CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.v_agg_del_qty_str_dy_1 AS
SELECT DY.client_id,
 DY.item_sid,
 DY.loc_sid_store_move_to,
 DY.wh_loc_sid,
 DY.wh_id,
 DY.aspect_id,
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