CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_item_client_order_delivery_hist_2 (client_id, mdm_item_sid, client_id_order
, int_org_sid, country_del_seq_nr, cy_week_delivery, country_request_qty, country_delivery_qty, deleted_fg,
dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 mdm_item_sid,
 client_id_order,
 int_org_sid,
 country_del_seq_nr,
 cy_week_delivery,
 country_request_qty,
 country_delivery_qty,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_item_client_order_delivery_hist_2;