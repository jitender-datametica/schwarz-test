CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_sup_deliv_loyalty_1 (sup_sid, item_sid, client_id, wh_loc_sid,
target_deliv_date, dispo_type, sum_qty_total_rcv_day, sum_qty_order) AS SELECT sup_sid,
 item_sid,
 client_id,
 wh_loc_sid,
 target_deliv_date,
 dispo_type,
 sum_qty_total_rcv_day,
 sum_qty_order
FROM ldl_p_lew_core.t_wawi_sup_deliv_loyalty_1;