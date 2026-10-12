CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_stc_change_item_wh (client_id, wh_loc_sid, item_sid, dat_formdate,
inv_id_stc_change, stc_change_type_cd, qty_piece_stc_change, price_retail_stc_change, price_retail_net_stc_change,
load_id) AS SELECT client_id,
 wh_loc_sid,
 item_sid,
 dat_formdate,
 inv_id_stc_change,
 stc_change_type_cd,
 qty_piece_stc_change,
 price_retail_stc_change,
 price_retail_net_stc_change,
 load_id
FROM ldl_p_lew_core.t_wawi_stc_change_item_wh;