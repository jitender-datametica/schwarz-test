
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_gruppe_gruppe_matrix (gruppe_parent_id, gruppe_id, pflegeflag
) AS SELECT V02.lbs_gruppe_id AS gruppe_parent_id,
 V01.lbs_gruppe_id AS gruppe_id,
  CASE
  WHEN (SELECT COUNT(*)
    FROM kfl_production_dbp_security.lbs_gruppe_gruppe_zu AS X
    WHERE lbs_gruppe_id = x.lbs_gruppe_id
     AND lbs_gruppe_parent_id = x.lbs_gruppe_parent_id) > 0
  THEN 1
  ELSE 0
  END AS pflegeflag
FROM kfl_production_dbp_security.lbs_gruppe AS V01
 INNER JOIN kfl_production_dbp_security.lbs_gruppe AS V02 ON V01.lbs_gruppe_id <> V02.lbs_gruppe_id
WHERE V01.lbs_gruppe_id <> 0
 AND V02.lbs_gruppe_id <> 0
 AND V02.lbs_gruppe_id NOT IN (SELECT lbs_gruppe_id
   FROM kfl_production_dbp_security.lbs_gruppe_zek_zu AS V03);
