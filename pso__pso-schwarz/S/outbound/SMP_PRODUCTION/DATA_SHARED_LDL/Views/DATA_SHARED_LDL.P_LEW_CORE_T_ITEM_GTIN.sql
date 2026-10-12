CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_item_gtin (client_id, item_sid, uom_sid, src_lfnum,
uom_cd, gtin, gtin_type_cd, main_gtin_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
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
FROM ldl_p_lew_core.t_item_gtin;