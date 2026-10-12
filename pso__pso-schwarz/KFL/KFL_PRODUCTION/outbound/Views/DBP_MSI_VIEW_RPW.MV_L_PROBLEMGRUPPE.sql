CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_problemgruppe (system_id, mandant_id, problemgruppe_id) AS
SELECT 7 AS system_id,
 mandant_id,
 problemgruppe_id
FROM kfl_production_dbp_view.v_l_problemgruppe
WHERE mandant_id = 1;