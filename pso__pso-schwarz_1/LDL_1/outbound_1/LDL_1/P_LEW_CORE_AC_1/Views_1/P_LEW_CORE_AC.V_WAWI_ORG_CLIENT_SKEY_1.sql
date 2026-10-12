CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_client_skey_1 (client_id, country_group_id, load_id) AS SELECT
 client_id,
 country_group_id,
 load_id
FROM ldl_p_lew_core.t_wawi_org_client_skey_1;