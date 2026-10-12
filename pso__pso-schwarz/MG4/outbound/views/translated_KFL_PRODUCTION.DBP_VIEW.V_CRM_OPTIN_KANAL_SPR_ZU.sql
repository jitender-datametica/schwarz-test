CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_optin_kanal_spr_zu (crm_optin_kanal_id, spr_id, crm_optin_kanal_bez
, td_insert, td_update) AS SELECT crm_optin_kanal_id,
 spr_id,
 crm_optin_kanal_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.crm_optin_kanal_spr_zu;