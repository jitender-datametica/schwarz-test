CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_brand_2 (client_id, brand_sid, src_brand_cd, brand_name, brand_type_cd,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 brand_sid,
 src_brand_cd,
 brand_name,
 brand_type_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_brand_2;