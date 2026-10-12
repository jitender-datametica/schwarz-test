CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_gruppe_gruppe_zu (gruppe_hier_1_id, gruppe_hier_2_id,
gruppe_hier_3_id) AS SELECT v03.gruppe_id AS gruppe_hier_1_id,
 COALESCE(V04.gruppe_id, 0) AS gruppe_hier_2_id,
 COALESCE(V05.gruppe_id, 0) AS gruppe_hier_3_id
FROM (SELECT gruppe_id
  FROM kfl_production_dbp_security.gruppe AS V01
  WHERE gruppe_id <> 0
   AND gruppe_id NOT IN (SELECT gruppe_id
     FROM kfl_production_dbp_security.gruppe_gruppe_zu AS V02)) AS v03
 LEFT JOIN kfl_production_dbp_security.gruppe_gruppe_zu AS V04 ON v03.gruppe_id = V04.gruppe_parent_id
 LEFT JOIN kfl_production_dbp_security.gruppe_gruppe_zu AS V05 ON V04.gruppe_id = V05.gruppe_parent_id;