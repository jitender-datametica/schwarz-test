CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_brand_type (client_id, brand_type_cd, brand_type, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 brand_type_cd,
 brand_type,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_brand_type;