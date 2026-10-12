CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_kfl_brand_1 (client_id, kfl_brand_sid, kfl_brand_name, brand_type_cd,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 kfl_brand_sid,
 kfl_brand_name,
 brand_type_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_kfl_brand_1;