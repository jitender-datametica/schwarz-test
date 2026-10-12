CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_optin_statusgrund_spr_zu (optin_statusgrund_id, spr_id,
optin_statusgrund_bez, td_insert, td_update) AS SELECT optin_statusgrund_id,
 spr_id,
 optin_statusgrund_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.crm_optin_statusgrund_spr_zu;