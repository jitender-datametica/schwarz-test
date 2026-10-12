CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_dim_brand_2 AS SELECT client_id,
 brand_sid,
 brand_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_bil.t_dim_brand_2;