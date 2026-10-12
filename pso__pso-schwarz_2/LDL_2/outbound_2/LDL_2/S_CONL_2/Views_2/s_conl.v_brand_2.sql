CREATE OR REPLACE VIEW ldl_s_conl.v_brand_2 AS SELECT client_id,
 brand_sid,
 src_brand_cd,
 brand_name,
 brand_type_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core_ac.v_brand_2
WHERE client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping_2
   WHERE LOWER(user_name) = LOWER(SESSION_USER()));