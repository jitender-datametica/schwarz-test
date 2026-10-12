CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_pruefkatalog_code_spr_zu_2 (katalogart_id, codegruppe_id,
pruefcode_id, version_id, qtxt_code, qtxt_code_de, qtxt_code_cz, qtxt_code_sk, qtxt_code_hr, qtxt_code_pl, qtxt_code_ro
, qtxt_code_bg) AS ((SELECT katalogart_id,
    CASE
    WHEN codegruppe_id = 'KLOAUTM'
    THEN SUBSTR(codegruppe_id, 1, 3)
    ELSE codegruppe_id
    END AS codegruppe1_id,
   pruefcode_id,
   version_id,
   MAX(CASE
     WHEN spr_id = 22
     THEN qtxt_code
     ELSE NULL
     END) AS qtxt_code,
   MAX(CASE
     WHEN spr_id = 22
     THEN qtxt_code
     ELSE NULL
     END) AS qtxt_code_de,
   COALESCE(MAX(CASE
      WHEN spr_id = 124
      THEN qtxt_code
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN qtxt_code
      ELSE NULL
      END)) AS qtxt_code_cz,
   COALESCE(MAX(CASE
      WHEN spr_id = 108
      THEN qtxt_code
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN qtxt_code
      ELSE NULL
      END)) AS qtxt_code_sk,
   COALESCE(MAX(CASE
      WHEN spr_id = 65
      THEN qtxt_code
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN qtxt_code
      ELSE NULL
      END)) AS qtxt_code_hr,
   COALESCE(MAX(CASE
      WHEN spr_id = 90
      THEN qtxt_code
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN qtxt_code
      ELSE NULL
      END)) AS qtxt_code_pl,
   COALESCE(MAX(CASE
      WHEN spr_id = 95
      THEN qtxt_code
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN qtxt_code
      ELSE NULL
      END)) AS qtxt_code_ro,
   COALESCE(MAX(CASE
      WHEN spr_id = 18
      THEN qtxt_code
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN qtxt_code
      ELSE NULL
      END)) AS qtxt_code_bg
  FROM kfl_production_dbp_view.v_in_pruefkatalog_code_spr_zu_2 AS V01
  GROUP BY katalogart_id,
   codegruppe1_id,
   pruefcode_id,
   version_id
  UNION DISTINCT
  SELECT '0' AS katalogart_id,
   '-1' AS codegruppe_id,
   '-1' AS pruefcode_id,
   '-1' AS version_id,
   '' AS qtxt_code,
   '' AS qtxt_code_de,
   '' AS qtxt_code_cz,
   '' AS qtxt_code_sk,
   '' AS qtxt_code_hr,
   '' AS qtxt_code_pl,
   '' AS qtxt_code_ro,
   '' AS qtxt_code_bg)
 UNION DISTINCT
 SELECT '0' AS katalogart_id,
  '-1' AS codegruppe_id,
  '0' AS pruefcode_id,
  '-1' AS version_id,
  '' AS qtxt_code,
  '' AS qtxt_code_de,
  '' AS qtxt_code_cz,
  '' AS qtxt_code_sk,
  '' AS qtxt_code_hr,
  '' AS qtxt_code_pl,
  '' AS qtxt_code_ro,
  '' AS qtxt_code_bg)
UNION DISTINCT
SELECT '0' AS katalogart_id,
 '-1' AS codegruppe_id,
 pruefcode_id,
 '-1' AS version_id,
 '' AS qtxt_code,
 '' AS qtxt_code_de,
 '' AS qtxt_code_cz,
 '' AS qtxt_code_sk,
 '' AS qtxt_code_hr,
 '' AS qtxt_code_pl,
 '' AS qtxt_code_ro,
 '' AS qtxt_code_bg
FROM kfl_production_dbp_view.v_in_pruefkatalog_code_spr_zu_2 AS V01
GROUP BY V01.katalogart_id,
 V01.codegruppe_id,
 pruefcode_id,
 V01.version_id;