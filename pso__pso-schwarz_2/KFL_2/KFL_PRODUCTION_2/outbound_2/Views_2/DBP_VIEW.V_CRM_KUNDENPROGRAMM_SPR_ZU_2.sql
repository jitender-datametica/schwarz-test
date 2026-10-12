CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_kundenprogramm_spr_zu_2 AS SELECT crm_kundenprogramm_id,
 spr_id,
 crm_kundenprogramm_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.crm_kundenprogramm_spr_zu_2;