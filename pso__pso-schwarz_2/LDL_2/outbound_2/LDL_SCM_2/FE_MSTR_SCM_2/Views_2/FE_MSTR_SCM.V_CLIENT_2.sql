CREATE OR REPLACE VIEW ldl_scm_fe_mstr_scm.v_client_2 (client_id, client_name, country_cd, dwh_updated, dwh_created) AS
SELECT client_id,
 client_name,
 country_cd,
 dwh_updated_tmsp AS dwh_updated,
 dwh_created_tmsp AS dwh_created
FROM ldl_scm_core.v_client_2;