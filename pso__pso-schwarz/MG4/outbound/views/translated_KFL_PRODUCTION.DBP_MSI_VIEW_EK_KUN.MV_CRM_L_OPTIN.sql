CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_optin (crm_optin_id, crm_optin_typ_id,
crm_optin_herkunft_id, crm_optin_kanal_id, crm_optin_bez_id) AS SELECT crm_optin_id,
 crm_optin_typ_id,
 crm_optin_herkunft_id,
 crm_optin_kanal_id,
 crm_optin_bez_id
FROM kfl_production_dbp_view.v_crm_l_optin;