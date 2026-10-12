CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_del_qty_str_mth (client_id, item_sid, loc_sid_store, cy_month,
busyear, currency_iso_cd, del_qty_nfv_val, del_qty_fv_val, del_qty_brk_alc_val) AS SELECT client_id,
 item_sid,
 loc_sid_store,
 cy_month,
 busyear,
 currency_iso_cd,
 del_qty_nfv_val,
 del_qty_fv_val,
 del_qty_brk_alc_val
FROM ldl_p_lew_mart_lead.v_agg_del_qty_str_mth;