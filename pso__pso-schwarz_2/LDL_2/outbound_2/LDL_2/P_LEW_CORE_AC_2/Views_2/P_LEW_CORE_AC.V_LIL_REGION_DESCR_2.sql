CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_lil_region_descr_2 (client_id, region_sid, lang_cd, region_name,
region_long_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 region_sid,
 lang_cd,
 region_name,
 region_long_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_lil_region_descr_2;