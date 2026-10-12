CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_client_country_bo_1 (client_id, country_id) AS SELECT client_id,
 country_id
FROM ldl_p_lew_core_ac.v_wawi_ref_client_country_1 AS V;