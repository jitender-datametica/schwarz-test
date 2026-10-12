CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_qual_ursache_1 (mandant_id, qual_meldung_id,
qual_meldung_pos_id, qual_meldung_ursache_id, katalogart_id, codegruppe_id, pruefcode_id, version_id) AS SELECT IN_Q_U.mandant_id
 ,
 IN_Q_U.qual_meldung_id,
 IN_Q_U.qual_meldung_pos_id,
 IN_Q_U.qual_meldung_ursache_id,
 IN_Q_U.katalogart_id,
  CASE
  WHEN IN_Q_U.codegruppe_id = 'KLOAUTM'
  THEN SUBSTR(IN_Q_U.codegruppe_id, 1, 3)
  ELSE IN_Q_U.codegruppe_id
  END AS codegruppe_id,
 IN_Q_U.pruefcode_id,
 IN_Q_U.version_id
FROM kfl_production_dbp_view.v_in_qual_ursache_1 AS IN_Q_U
 INNER JOIN (SELECT mandant_id,
   qual_meldung_id,
   MIN(qual_meldung_pos_id) AS qual_meldung_pos_id
  FROM kfl_production_dbp_view.v_in_qual_ursache_1
  GROUP BY mandant_id,
   qual_meldung_id) AS qm_pos ON IN_Q_U.qual_meldung_pos_id = qm_pos.qual_meldung_pos_id AND IN_Q_U.qual_meldung_id =
    qm_pos.qual_meldung_id AND IN_Q_U.mandant_id = qm_pos.mandant_id
UNION DISTINCT
SELECT V02.mandant_id,
 v03.qual_meldung_id,
 - 1 AS qual_meldung_pos_id,
 - 1 AS qual_meldung_ursache_id,
 '0' AS katalogart_id,
 '-1' AS codegruppe_id,
 '-1' AS pruefcode_id,
 '-1' AS version_id
FROM kfl_production_dbp_view.v_mandant_1 AS V02
 INNER JOIN (SELECT mandant_id,
   qual_meldung_id
  FROM kfl_production_dbp_view.v_in_qual_instand_1 AS V03
  WHERE (mandant_id, qual_meldung_id) NOT IN (SELECT (mandant_id, qual_meldung_id)
     FROM kfl_production_dbp_view.v_in_qual_ursache_1
     GROUP BY mandant_id,
      qual_meldung_id)) AS v03 ON V02.mandant_id = v03.mandant_id;