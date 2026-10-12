CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_gruppe_hier_1 (gruppe_hier_1_id, gruppe_hier_1_bez) AS
SELECT gruppe_id AS gruppe_hier_1_id,
 gruppe_bez AS gruppe_hier_1_bez
FROM kfl_production_dbp_security.gruppe AS V01
WHERE gruppe_id <> 0;