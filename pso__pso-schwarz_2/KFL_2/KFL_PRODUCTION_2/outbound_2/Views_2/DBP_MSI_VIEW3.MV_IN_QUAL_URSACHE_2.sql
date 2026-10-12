CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_in_qual_ursache_2 (mandant_id, qual_meldung_id, qual_meldung_pos_id
, qual_meldung_ursache_id, katalogart_id, codegruppe_id, pruefcode_id, version_id) AS SELECT mandant_id,
 qual_meldung_id,
 qual_meldung_pos_id,
 qual_meldung_ursache_id,
 katalogart_id,
  CASE
  WHEN codegruppe_id = 'KLOAUTM'
  THEN SUBSTR(codegruppe_id, 1, 3)
  ELSE codegruppe_id
  END AS codegruppe_id,
 pruefcode_id,
 version_id
FROM kfl_production_dbp_view.v_in_qual_ursache_2 AS V01
UNION DISTINCT
SELECT V02.mandant_id,
 v03.qual_meldung_id,
 - 1 AS qual_meldung_pos_id,
 - 1 AS qual_meldung_ursache_id,
 '0' AS katalogart_id,
 '-1' AS codegruppe_id,
 '-1' AS pruefcode_id,
 '-1' AS version_id
FROM kfl_production_dbp_view.v_mandant_2 AS V02
 INNER JOIN (SELECT mandant_id,
   qual_meldung_id
  FROM kfl_production_dbp_view.v_in_qual_instand_2 AS V03
  WHERE (mandant_id, qual_meldung_id) NOT IN (SELECT (mandant_id, qual_meldung_id)
     FROM kfl_production_dbp_view.v_in_qual_ursache_2
     GROUP BY mandant_id,
      qual_meldung_id)) AS v03 ON V02.mandant_id = v03.mandant_id;