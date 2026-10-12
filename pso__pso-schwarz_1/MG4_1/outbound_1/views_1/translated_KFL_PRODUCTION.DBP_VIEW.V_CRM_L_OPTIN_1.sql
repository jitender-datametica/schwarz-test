CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_l_optin_1 (crm_optin_id, crm_optin_typ_id, crm_optin_herkunft_id,
crm_optin_kanal_id, crm_optin_bez_id, td_insert, td_update) AS SELECT crm_optin_id,
 crm_optin_typ_id,
 crm_optin_herkunft_id,
 crm_optin_kanal_id,
 crm_optin_bez_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.crm_l_optin_1;