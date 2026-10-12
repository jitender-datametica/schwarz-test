CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_location_brand_hist_2 (client_id, item_sid, loc_sid, brand_sid,
brand_type_mark, brand_type_label, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 item_sid,
 loc_sid,
 brand_sid,
 brand_type_mark,
 brand_type_label,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_location_brand_hist_2;