CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.v_agg_del_qty_str_mth_2 AS
SELECT MTH.client_id,
 MTH.item_sid,
 MTH.loc_sid_store_move_to,
 MTH.wh_loc_sid,
 MTH.wh_id,
 MTH.aspect_id,
 MTH.cy_month,
 MTH.busyear,
 CRY.currency_iso_cd,
 MTH.del_qty_nfv_val,
 MTH.del_qty_fv_val,
 MTH.del_qty_brk_alc_val
FROM ldl_p_lew_mart_lead.t_agg_del_qty_str_mth_2 AS MTH
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON MTH.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;