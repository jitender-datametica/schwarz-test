CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_prozessbereich_1 (system_id, mandant_id, prozessbereich_id) AS
SELECT 7 AS system_id,
 mandant_id,
 prozessbereich_id
FROM kfl_production_dbp_view.v_l_prozessbereich_1
WHERE mandant_id = 1;