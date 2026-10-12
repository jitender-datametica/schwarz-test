CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_artkz_lead (lead_id, lead_bez, mandant_id, spr_id, system_id)
AS SELECT lead_id,
 lead_bez,
 mandant_id,
 spr_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_artkz_lead
WHERE mandant_id = 1;