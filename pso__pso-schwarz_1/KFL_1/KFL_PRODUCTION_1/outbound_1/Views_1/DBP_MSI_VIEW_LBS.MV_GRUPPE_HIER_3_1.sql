CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_gruppe_hier_3_1 (gruppe_hier_3_id, gruppe_hier_3_bez) AS SELECT
 lbs_gruppe_id AS gruppe_hier_3_id,
  CASE
  WHEN lbs_gruppe_id = 0
  THEN ''
  ELSE lbs_gruppe_bez
  END AS gruppe_hier_3_bez
FROM kfl_production_dbp_security.lbs_gruppe_1 AS V01;