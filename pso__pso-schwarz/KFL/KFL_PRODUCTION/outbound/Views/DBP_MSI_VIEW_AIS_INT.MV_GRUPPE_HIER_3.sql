CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_gruppe_hier_3 (gruppe_hier_3_id, gruppe_hier_3_bez) AS
SELECT gruppe_id AS gruppe_hier_3_id,
  CASE
  WHEN gruppe_id = 0
  THEN ''
  ELSE gruppe_bez
  END AS gruppe_hier_3_bez
FROM kfl_production_dbp_security.gruppe AS V01;