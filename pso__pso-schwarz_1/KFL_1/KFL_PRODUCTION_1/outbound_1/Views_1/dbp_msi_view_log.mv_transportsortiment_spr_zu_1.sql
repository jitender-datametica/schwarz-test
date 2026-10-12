CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_transportsortiment_spr_zu_1 AS ((SELECT mandant_id,
   lagernummer_id,
   wup_id,
   nb_id,
   CAST(lagersortiment_id AS STRING) AS transportsortiment_id,
   MAX(CASE
     WHEN spr_id = 22
     THEN lagersortiment_bez
     ELSE NULL
     END) AS lagersortiment_bez,
   MAX(CASE
     WHEN spr_id = 22
     THEN lagersortiment_bez
     ELSE NULL
     END) AS lagersortiment_bez_de,
   COALESCE(MAX(CASE
      WHEN spr_id = 124
      THEN lagersortiment_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN lagersortiment_bez
      ELSE NULL
      END)) AS lagersortiment_bez_cz,
   COALESCE(MAX(CASE
      WHEN spr_id = 108
      THEN lagersortiment_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN lagersortiment_bez
      ELSE NULL
      END)) AS lagersortiment_bez_sk,
   COALESCE(MAX(CASE
      WHEN spr_id = 65
      THEN lagersortiment_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN lagersortiment_bez
      ELSE NULL
      END)) AS lagersortiment_bez_hr,
   COALESCE(MAX(CASE
      WHEN spr_id = 90
      THEN lagersortiment_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN lagersortiment_bez
      ELSE NULL
      END)) AS lagersortiment_bez_pl,
   COALESCE(MAX(CASE
      WHEN spr_id = 95
      THEN lagersortiment_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN lagersortiment_bez
      ELSE NULL
      END)) AS lagersortiment_bez_ro,
   COALESCE(MAX(CASE
      WHEN spr_id = 18
      THEN lagersortiment_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN lagersortiment_bez
      ELSE NULL
      END)) AS lagersortiment_bez_bg
  FROM kfl_production_dbp_view.v_lagersortiment_spr_zu_1 AS V01
  WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
   AND LENGTH(TRIM(lagernummer_id)) = 4
   AND wup_id > 0
   AND lagersortiment_id NOT IN ('2', '5', '7')
  GROUP BY mandant_id,
   lagernummer_id,
   lagersortiment_id,
   wup_id,
   nb_id
  UNION DISTINCT
  SELECT mandant_id,
   lagernummer_id,
   wup_id,
   nb_id,
   '27' AS transportsortiment_id,
   'OG / Pflanzen' AS lagersortiment_bez,
   'OG / Pflanzen' AS lagersortiment_bez_de,
   'F&V / Plants' AS lagersortiment_bez_cz,
   'F&V / Plants' AS lagersortiment_bez_sk,
   'F&V / Plants' AS lagersortiment_bez_hr,
   'F&V / Plants' AS lagersortiment_bez_pl,
   'F&V / Plants' AS lagersortiment_bez_ro,
   'F&V / Plants' AS lagersortiment_bez_bg
  FROM kfl_production_dbp_view.v_lagersortiment_spr_zu_1 AS V01
  WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
   AND LENGTH(TRIM(lagernummer_id)) = 4
   AND lagersortiment_id = '2'
   AND wup_id > 0
  GROUP BY mandant_id,
   lagernummer_id,
   lagersortiment_id,
   wup_id,
   nb_id)
 UNION DISTINCT
 SELECT mandant_id,
  lagernummer_id,
  wup_id,
  nb_id,
  '-1' AS transportsortiment_id,
  'kein BELOS-Vorgang' AS lagersortiment_bez,
  'kein BELOS-Vorgang' AS lagersortiment_bez_de,
  'no BELOS data' AS lagersortiment_bez_cz,
  'no BELOS data' AS lagersortiment_bez_sk,
  'no BELOS data' AS lagersortiment_bez_hr,
  'no BELOS data' AS lagersortiment_bez_pl,
  'no BELOS data' AS lagersortiment_bez_ro,
  'no BELOS data' AS lagersortiment_bez_bg
 FROM kfl_production_dbp_view.v_lagersortiment_spr_zu_1 AS V01
 WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
  AND LENGTH(TRIM(lagernummer_id)) = 4
  AND lagersortiment_id = '2'
  AND wup_id > 0
 GROUP BY mandant_id,
  lagernummer_id,
  lagersortiment_id,
  wup_id,
  nb_id)
UNION DISTINCT
SELECT mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 '99' AS transportsortiment_id,
 'Transportsortiment nicht eindeutig' AS lagersortiment_bez,
 'Transportsortiment nicht eindeutig' AS lagersortiment_bez_de,
 'Transportation assortment not unique' AS lagersortiment_bez_cz,
 'Transportation assortment not unique' AS lagersortiment_bez_sk,
 'Transportation assortment not unique' AS lagersortiment_bez_hr,
 'Transportation assortment not unique' AS lagersortiment_bez_pl,
 'Transportation assortment not unique' AS lagersortiment_bez_ro,
 'Transportation assortment not unique' AS lagersortiment_bez_bg
FROM kfl_production_dbp_view.v_lagersortiment_spr_zu_1 AS V01
WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND LENGTH(TRIM(lagernummer_id)) = 4
 AND lagersortiment_id = '2'
 AND wup_id > 0
GROUP BY mandant_id,
 lagernummer_id,
 lagersortiment_id,
 wup_id,
 nb_id;