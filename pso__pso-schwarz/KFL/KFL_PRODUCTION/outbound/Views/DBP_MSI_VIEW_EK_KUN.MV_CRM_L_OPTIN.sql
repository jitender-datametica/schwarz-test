CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_optin (crm_optin_id, crm_loyalty_fg,
crm_optin_kanal_id) AS SELECT crm_optin_id,
 crm_loyalty_fg,
 crm_optin_kanal_cd AS crm_optin_kanal_id
FROM kfl_production_dbp_data.crm_l_optin;