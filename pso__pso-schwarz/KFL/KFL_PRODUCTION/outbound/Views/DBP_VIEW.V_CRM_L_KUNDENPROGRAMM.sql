CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_l_kundenprogramm AS SELECT crm_kundenprogramm_id,
 mandant_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.crm_l_kundenprogramm;