CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_artkz_lead (mandant_id, lead_id, lead_bez) AS SELECT
 mandant_id,
 lead_id,
 lead_bez
FROM kfl_production_dbp_view.v_artkz_lead
WHERE mandant_id = 1;