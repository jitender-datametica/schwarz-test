CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_org_client_skey_2 (client_id, country_group_id) AS SELECT client_id,
 country_group_id
FROM ldl_p_lew_core_ac.v_wawi_org_client_skey_2 AS V;