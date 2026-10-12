CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_wg_hier_denorm_2 AS ((((SELECT in_wg_struktur_id AS
     in_wg_ebene1_id,
     in_wg_struktur_id AS in_wg_ebene2_id,
     in_wg_struktur_id AS in_wg_ebene3_id,
     in_wg_struktur_id AS in_wg_ebene4_id,
     in_wg_struktur_id AS in_wg_ebene5_id,
     in_wg_struktur_id AS in_wg_ebene6_id
    FROM kfl_production_dbp_view.v_in_wg_struktur_2
    WHERE in_wg_struktur_ebene_id = 1
     AND in_wg_struktur_id NOT IN (SELECT in_wg_struktur_mutter_id
       FROM kfl_production_dbp_view.v_in_wg_struktur_2
       WHERE in_wg_struktur_ebene_id = 2)
    UNION DISTINCT
    SELECT in_wg_struktur_mutter_id AS in_wg_ebene1_id,
     in_wg_struktur_id AS in_wg_ebene2_id,
     in_wg_struktur_id AS in_wg_ebene3_id,
     in_wg_struktur_id AS in_wg_ebene4_id,
     in_wg_struktur_id AS in_wg_ebene5_id,
     in_wg_struktur_id AS in_wg_ebene6_id
    FROM kfl_production_dbp_view.v_in_wg_struktur_2 AS E2
    WHERE in_wg_struktur_ebene_id = 2
     AND in_wg_struktur_id NOT IN (SELECT in_wg_struktur_mutter_id
       FROM kfl_production_dbp_view.v_in_wg_struktur_2
       WHERE in_wg_struktur_ebene_id = 3))
   UNION DISTINCT
   SELECT E2.in_wg_struktur_mutter_id AS in_wg_ebene1_id,
    E3.in_wg_struktur_mutter_id AS in_wg_ebene2_id,
    E3.in_wg_struktur_id AS in_wg_ebene3_id,
    E3.in_wg_struktur_id AS in_wg_ebene4_id,
    E3.in_wg_struktur_id AS in_wg_ebene5_id,
    E3.in_wg_struktur_id AS in_wg_ebene6_id
   FROM kfl_production_dbp_view.v_in_wg_struktur_2 AS E3
    INNER JOIN kfl_production_dbp_view.v_in_wg_struktur_2 AS E2 ON E3.in_wg_struktur_ebene_id = 3 AND E2.in_wg_struktur_ebene_id
        = 2 AND E3.in_wg_struktur_mutter_id = E2.in_wg_struktur_id
   WHERE E3.in_wg_struktur_ebene_id = 3
    AND E3.in_wg_struktur_id NOT IN (SELECT in_wg_struktur_mutter_id
      FROM kfl_production_dbp_view.v_in_wg_struktur_2
      WHERE in_wg_struktur_ebene_id = 4))
  UNION DISTINCT
  SELECT E2.in_wg_struktur_mutter_id AS in_wg_ebene1_id,
   E3.in_wg_struktur_mutter_id AS in_wg_ebene2_id,
   E3.in_wg_struktur_id AS in_wg_ebene3_id,
   E4.in_wg_struktur_id AS in_wg_ebene4_id,
   E4.in_wg_struktur_id AS in_wg_ebene5_id,
   E4.in_wg_struktur_id AS in_wg_ebene6_id
  FROM kfl_production_dbp_view.v_in_wg_struktur_2 AS E4
   INNER JOIN kfl_production_dbp_view.v_in_wg_struktur_2 AS E3 ON E4.in_wg_struktur_mutter_id = E3.in_wg_struktur_id
   INNER JOIN kfl_production_dbp_view.v_in_wg_struktur_2 AS E2 ON E3.in_wg_struktur_mutter_id = E2.in_wg_struktur_id
  WHERE E2.in_wg_struktur_ebene_id = 2
   AND E3.in_wg_struktur_ebene_id = 3
   AND E4.in_wg_struktur_ebene_id = 4
   AND E4.in_wg_struktur_id NOT IN (SELECT in_wg_struktur_mutter_id
     FROM kfl_production_dbp_view.v_in_wg_struktur_2
     WHERE in_wg_struktur_ebene_id = 5))
 UNION DISTINCT
 SELECT E2.in_wg_struktur_mutter_id AS in_wg_ebene1_id,
  E3.in_wg_struktur_mutter_id AS in_wg_ebene2_id,
  E3.in_wg_struktur_id AS in_wg_ebene3_id,
  E4.in_wg_struktur_id AS in_wg_ebene4_id,
  E5.in_wg_struktur_id AS in_wg_ebene5_id,
  E5.in_wg_struktur_id AS in_wg_ebene6_id
 FROM kfl_production_dbp_view.v_in_wg_struktur_2 AS E5
  INNER JOIN kfl_production_dbp_view.v_in_wg_struktur_2 AS E4 ON E5.in_wg_struktur_mutter_id = E4.in_wg_struktur_id
  INNER JOIN kfl_production_dbp_view.v_in_wg_struktur_2 AS E3 ON E4.in_wg_struktur_mutter_id = E3.in_wg_struktur_id
  INNER JOIN kfl_production_dbp_view.v_in_wg_struktur_2 AS E2 ON E3.in_wg_struktur_mutter_id = E2.in_wg_struktur_id
 WHERE E2.in_wg_struktur_ebene_id = 2
  AND E3.in_wg_struktur_ebene_id = 3
  AND E4.in_wg_struktur_ebene_id = 4
  AND E5.in_wg_struktur_ebene_id = 5
  AND E5.in_wg_struktur_id NOT IN (SELECT in_wg_struktur_mutter_id
    FROM kfl_production_dbp_view.v_in_wg_struktur_2
    WHERE in_wg_struktur_ebene_id = 6))
UNION DISTINCT
SELECT E2.in_wg_struktur_mutter_id AS in_wg_ebene1_id,
 E3.in_wg_struktur_mutter_id AS in_wg_ebene2_id,
 E3.in_wg_struktur_id AS in_wg_ebene3_id,
 E4.in_wg_struktur_id AS in_wg_ebene4_id,
 E5.in_wg_struktur_id AS in_wg_ebene5_id,
 E6.in_wg_struktur_id AS in_wg_ebene6_id
FROM kfl_production_dbp_view.v_in_wg_struktur_2 AS E6
 INNER JOIN kfl_production_dbp_view.v_in_wg_struktur_2 AS E5 ON E6.in_wg_struktur_mutter_id = E5.in_wg_struktur_id
 INNER JOIN kfl_production_dbp_view.v_in_wg_struktur_2 AS E4 ON E5.in_wg_struktur_mutter_id = E4.in_wg_struktur_id
 INNER JOIN kfl_production_dbp_view.v_in_wg_struktur_2 AS E3 ON E4.in_wg_struktur_mutter_id = E3.in_wg_struktur_id
 INNER JOIN kfl_production_dbp_view.v_in_wg_struktur_2 AS E2 ON E3.in_wg_struktur_mutter_id = E2.in_wg_struktur_id
WHERE E2.in_wg_struktur_ebene_id = 2
 AND E3.in_wg_struktur_ebene_id = 3
 AND E4.in_wg_struktur_ebene_id = 4
 AND E5.in_wg_struktur_ebene_id = 5
 AND E6.in_wg_struktur_ebene_id = 6;