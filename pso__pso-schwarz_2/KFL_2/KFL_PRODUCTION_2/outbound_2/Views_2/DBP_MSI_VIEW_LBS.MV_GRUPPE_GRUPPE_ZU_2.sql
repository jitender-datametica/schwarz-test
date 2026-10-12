CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_gruppe_gruppe_zu_2 (gruppe_hier_1_id, gruppe_hier_2_id,
gruppe_hier_3_id) AS SELECT v03.lbs_gruppe_id AS gruppe_hier_1_id,
 COALESCE(V04.lbs_gruppe_id, 0) AS gruppe_hier_2_id,
 COALESCE(V05.lbs_gruppe_id, 0) AS gruppe_hier_3_id
FROM (SELECT lbs_gruppe_id
  FROM kfl_production_dbp_security.lbs_gruppe_2 AS V01
  WHERE lbs_gruppe_id <> 0
   AND lbs_gruppe_id NOT IN (SELECT lbs_gruppe_id
     FROM kfl_production_dbp_security.lbs_gruppe_gruppe_zu_2 AS V02)) AS v03
 LEFT JOIN kfl_production_dbp_security.lbs_gruppe_gruppe_zu_2 AS V04 ON v03.lbs_gruppe_id = V04.lbs_gruppe_parent_id
 LEFT JOIN kfl_production_dbp_security.lbs_gruppe_gruppe_zu_2 AS V05 ON V04.lbs_gruppe_id = V05.lbs_gruppe_parent_id;