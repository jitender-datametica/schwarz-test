CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_gtin_2 (client_id, item_sid, uom_sid, src_lfnum, uom_cd, gtin,
gtin_type_cd, main_gtin_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_sid,
 uom_sid,
 src_lfnum,
 uom_cd,
 gtin,
 gtin_type_cd,
 main_gtin_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_gtin_2;