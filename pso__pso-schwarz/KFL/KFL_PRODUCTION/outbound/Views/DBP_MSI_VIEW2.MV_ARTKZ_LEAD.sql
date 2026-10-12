CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_artkz_lead (lead_id, lead_bez) AS SELECT lead_id,
 lead_bez
FROM kfl_production_dbp_view.v_artkz_lead
WHERE mandant_id = 1;