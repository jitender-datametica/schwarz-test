CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_region_retailer_1 (client_id, region_sid, retailer_sid, rtl_id,
region_rtl_desc_de, region_rtl_desc_en, rtl_lvl, active_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 region_sid,
 retailer_sid,
 rtl_id,
 region_rtl_desc_de,
 region_rtl_desc_en,
 rtl_lvl,
 active_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_region_retailer_1;