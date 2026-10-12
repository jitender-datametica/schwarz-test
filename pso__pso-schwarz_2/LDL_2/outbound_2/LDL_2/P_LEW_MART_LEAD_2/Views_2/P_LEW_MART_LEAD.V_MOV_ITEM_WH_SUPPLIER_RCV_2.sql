CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_mov_item_wh_supplier_rcv_2 AS SELECT client_id,
 loc_sid_wh,
 src_wh_id,
 item_sid,
 sup_sid,
 dat_formdate,
 cy_week
FROM ldl_p_lew_mart_lead.t_mov_item_wh_supplier_rcv_2;