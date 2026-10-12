CREATE OR REPLACE VIEW ldl_scm_core.v_client_1 (client_id, client_name, country_cd, dwh_updated_tmsp, dwh_created_tmsp) AS
SELECT *
FROM ldl_scm_core_rel.t_client_1;