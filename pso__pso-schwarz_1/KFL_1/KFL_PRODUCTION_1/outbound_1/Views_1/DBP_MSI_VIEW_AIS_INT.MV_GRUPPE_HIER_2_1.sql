CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_gruppe_hier_2_1 (gruppe_hier_2_id, gruppe_hier_2_bez) AS
SELECT gruppe_id AS gruppe_hier_2_id,
  CASE
  WHEN gruppe_id = 0
  THEN ''
  ELSE gruppe_bez
  END AS gruppe_hier_2_bez
FROM kfl_production_dbp_security.gruppe_1 AS V01;