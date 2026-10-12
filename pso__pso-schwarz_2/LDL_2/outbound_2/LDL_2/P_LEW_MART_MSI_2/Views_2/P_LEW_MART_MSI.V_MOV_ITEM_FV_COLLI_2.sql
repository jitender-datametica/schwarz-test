CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mov_item_fv_colli_2 (client_id, store_id, item_id, dat_formdate,
case_size_real) AS SELECT client_id,
 loc_sid_store AS store_id,
 item_sid AS item_id,
 last_delivery_dt AS dat_formdate,
 min_case_size_dec AS case_size_real
FROM ldl_p_lew_core_ac.v_item_fruits_vegetables_store_info_2 AS V;