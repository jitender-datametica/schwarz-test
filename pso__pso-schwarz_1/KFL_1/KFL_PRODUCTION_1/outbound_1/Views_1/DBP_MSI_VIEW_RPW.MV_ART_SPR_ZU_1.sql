CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_art_spr_zu_1 (spr_id, art_id, mandant_id, art_bez, system_id) AS
(((SELECT spr_id,
    art_id,
    mandant_id,
     CASE
     WHEN SUBSTR(art_bez, 1, 11) = 'Wertartikel' AND art_id < 0
     THEN 'Sachkonto WG ' || TRIM(SUBSTR(CAST(art_id / - 1000 AS STRING), 1, 20))
     ELSE art_bez
     END AS art_bez,
    7 AS system_id
   FROM kfl_production_dbp_view.v_art_spr_zu_1
   WHERE mandant_id = 1
    AND spr_id = 22
   UNION DISTINCT
   SELECT spr_id,
     art_id - 1 AS art_id,
    mandant_id,
     CASE
     WHEN SUBSTR(art_bez, 1, 11) = 'Wertartikel' AND art_id < 0
     THEN 'Sachkonto WG ' || TRIM((CAST(art_id / - 1000 AS STRING) || '_76_78_95_96'))
     ELSE art_bez
     END AS art_bez,
    7 AS system_id
   FROM kfl_production_dbp_view.v_art_spr_zu_1
   WHERE mandant_id = 1
    AND art_id BETWEEN - 999000 AND (- 1000)
    AND spr_id = 22)
  UNION DISTINCT
  SELECT spr_id,
    art_id - 2 AS art_id,
   mandant_id,
    CASE
    WHEN SUBSTR(art_bez, 1, 11) = 'Wertartikel' AND art_id < 0
    THEN 'Sachkonto WG ' || TRIM((CAST(art_id / - 1000 AS STRING) || '_55_79'))
    ELSE art_bez
    END AS art_bez,
   7 AS system_id
  FROM kfl_production_dbp_view.v_art_spr_zu_1
  WHERE mandant_id = 1
   AND art_id BETWEEN - 999000 AND (- 1000)
   AND spr_id = 22)
 UNION DISTINCT
 SELECT spr_id,
   art_id - 3 AS art_id,
  mandant_id,
   CASE
   WHEN SUBSTR(art_bez, 1, 11) = 'Wertartikel' AND art_id < 0
   THEN 'Sachkonto WG ' || TRIM((CAST(art_id / - 1000 AS STRING) || '_71_74'))
   ELSE art_bez
   END AS art_bez,
  7 AS system_id
 FROM kfl_production_dbp_view.v_art_spr_zu_1
 WHERE mandant_id = 1
  AND art_id BETWEEN - 999000 AND (- 1000)
  AND spr_id = 22)
UNION DISTINCT
SELECT spr_id,
  art_id - 9 AS art_id,
 mandant_id,
  CASE
  WHEN SUBSTR(art_bez, 1, 11) = 'Wertartikel' AND art_id < 0
  THEN 'Sachkonto WG ' || TRIM((CAST(art_id / - 1000 AS STRING) || '_99'))
  ELSE art_bez
  END AS art_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_art_spr_zu_1
WHERE mandant_id = 1
 AND art_id BETWEEN - 999000 AND (- 1000)
 AND spr_id = 22;