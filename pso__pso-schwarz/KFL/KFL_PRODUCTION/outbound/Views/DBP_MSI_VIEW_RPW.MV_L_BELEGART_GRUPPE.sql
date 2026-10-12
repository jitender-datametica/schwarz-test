CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_belegart_gruppe (system_id, mandant_id, belegart_gruppe_id)
AS SELECT 7 AS system_id,
 mandant_id,
 belegart_gruppe_id
FROM kfl_production_dbp_view.v_l_belegart_gruppe
WHERE mandant_id = 1;