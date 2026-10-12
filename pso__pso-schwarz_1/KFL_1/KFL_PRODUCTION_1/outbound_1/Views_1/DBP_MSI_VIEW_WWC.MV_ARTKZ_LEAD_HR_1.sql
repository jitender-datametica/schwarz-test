CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artkz_lead_hr_1 (mandant_id, lead_id, spr_id, lead_bez) AS
SELECT mandant_id,
 lead_id,
 spr_id,
 lead_bez
FROM kfl_production_dbp_view.v_artkz_lead_1 AS V01
WHERE spr_id = 65;