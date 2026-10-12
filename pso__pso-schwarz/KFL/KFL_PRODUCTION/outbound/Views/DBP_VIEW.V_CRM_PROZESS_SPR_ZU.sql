CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_prozess_spr_zu AS SELECT crm_prozess_id,
 spr_id,
 prozess_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.crm_prozess_spr_zu;