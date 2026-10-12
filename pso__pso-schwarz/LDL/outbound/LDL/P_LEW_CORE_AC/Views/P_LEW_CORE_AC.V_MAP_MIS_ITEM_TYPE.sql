CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_map_mis_item_type (client_id, brand_type_mark, brand_type_label,
list_type_mark, list_type_label, mis_buying_list_type_id, mis_buying_list_type_descr, dwh_load_id, dwh_created,
dwh_updated) AS SELECT client_id,
 brand_type_mark,
 brand_type_label,
 list_type_mark,
 list_type_label,
 mis_buying_list_type_id,
 mis_buying_list_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_map_mis_item_type;