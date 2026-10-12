CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_gruppe_gruppe_matrix_1 (gruppe_parent_id, gruppe_id,
pflegeflag) AS -- Ausschluss der DUMMY_1-ID 0
 SELECT V02.gruppe_id AS gruppe_parent_id,
 V01.gruppe_id,
  CASE
  WHEN (SELECT COUNT(*)
    FROM kfl_production_dbp_security.gruppe_gruppe_zu_1 AS X
    WHERE gruppe_id IS NOT NULL
     AND gruppe_parent_id IS NOT NULL) > 0
  THEN 1
  ELSE 0
  END AS pflegeflag
FROM kfl_production_dbp_security.gruppe_1 AS V01
 INNER JOIN kfl_production_dbp_security.gruppe_1 AS V02 ON V01.gruppe_id <> V02.gruppe_id
  -- Ausschluss von Gruppen als Elterngruppen denen bereits Mandanten / EKGs zugeordnet sind

WHERE V01.gruppe_id <> 0
 AND V02.gruppe_id <> 0 -- Ausschluss von Zuordnungen einer Gruppe_1 zu sich selbst

 AND V02.gruppe_id NOT IN (SELECT gruppe_id
   FROM kfl_production_dbp_security.gruppe_zek_zu_1 AS V03);