CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_crm_l_optin (crm_optin_id, crm_loyalty_fg,
crm_optin_kanal_cd, td_update, td_insert) AS SELECT crm_optin_id,
 crm_loyalty_fg,
 crm_optin_kanal_cd,
 td_update,
 td_insert
FROM kfl_production_dbp_data.crm_l_optin;