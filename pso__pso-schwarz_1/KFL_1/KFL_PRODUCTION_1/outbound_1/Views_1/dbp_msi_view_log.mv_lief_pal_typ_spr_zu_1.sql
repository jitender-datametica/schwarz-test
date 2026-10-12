CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lief_pal_typ_spr_zu_1 AS ((((SELECT lief_pal_typ_id,
     MAX(CASE
       WHEN spr_id = 22
       THEN lief_pal_typ_bez
       ELSE NULL
       END) AS lief_pal_typ_bez,
     MAX(CASE
       WHEN spr_id = 22
       THEN lief_pal_typ_bez
       ELSE NULL
       END) AS lief_pal_typ_bez_de,
     COALESCE(MAX(CASE
        WHEN spr_id = 124
        THEN lief_pal_typ_bez
        ELSE NULL
        END), MAX(CASE
        WHEN spr_id = 22
        THEN lief_pal_typ_bez
        ELSE NULL
        END)) AS lief_pal_typ_bez_cz,
     COALESCE(MAX(CASE
        WHEN spr_id = 108
        THEN lief_pal_typ_bez
        ELSE NULL
        END), MAX(CASE
        WHEN spr_id = 22
        THEN lief_pal_typ_bez
        ELSE NULL
        END)) AS lief_pal_typ_bez_sk,
     COALESCE(MAX(CASE
        WHEN spr_id = 65
        THEN lief_pal_typ_bez
        ELSE NULL
        END), MAX(CASE
        WHEN spr_id = 22
        THEN lief_pal_typ_bez
        ELSE NULL
        END)) AS lief_pal_typ_bez_hr,
     COALESCE(MAX(CASE
        WHEN spr_id = 90
        THEN lief_pal_typ_bez
        ELSE NULL
        END), MAX(CASE
        WHEN spr_id = 22
        THEN lief_pal_typ_bez
        ELSE NULL
        END)) AS lief_pal_typ_bez_pl,
     COALESCE(MAX(CASE
        WHEN spr_id = 95
        THEN lief_pal_typ_bez
        ELSE NULL
        END), MAX(CASE
        WHEN spr_id = 22
        THEN lief_pal_typ_bez
        ELSE NULL
        END)) AS lief_pal_typ_bez_ro,
     COALESCE(MAX(CASE
        WHEN spr_id = 18
        THEN lief_pal_typ_bez
        ELSE NULL
        END), MAX(CASE
        WHEN spr_id = 22
        THEN lief_pal_typ_bez
        ELSE NULL
        END)) AS lief_pal_typ_bez_bg
    FROM kfl_production_dbp_view.v_lief_pal_typ_spr_zu_1 AS V01
    GROUP BY lief_pal_typ_id
    UNION DISTINCT
    SELECT 'J4' AS lief_pal_typ_id,
     'AKA Food MP' AS lief_pal_typ_bez,
     'AKA Food MP' AS lief_pal_typ_bez_de,
     'AKA Food MP' AS lief_pal_typ_bez_cz,
     'AKA Food MP' AS lief_pal_typ_bez_sk,
     'AKA Food MP' AS lief_pal_typ_bez_hr,
     'AKA Food MP' AS lief_pal_typ_bez_pl,
     'AKA Food MP' AS lief_pal_typ_bez_ro,
     'AKA Food MP' AS lief_pal_typ_bez_bg
    FROM kfl_production_dbp_view.v_lief_pal_typ_spr_zu_1)
   UNION DISTINCT
   SELECT 'J9' AS lief_pal_typ_id,
    'AKA Food KKP' AS lief_pal_typ_bez,
    'AKA Food KKP' AS lief_pal_typ_bez_de,
    'AKA Food KKP' AS lief_pal_typ_bez_cz,
    'AKA Food KKP' AS lief_pal_typ_bez_sk,
    'AKA Food KKP' AS lief_pal_typ_bez_hr,
    'AKA Food KKP' AS lief_pal_typ_bez_pl,
    'AKA Food KKP' AS lief_pal_typ_bez_ro,
    'AKA Food KKP' AS lief_pal_typ_bez_bg
   FROM kfl_production_dbp_view.v_lief_pal_typ_spr_zu_1)
  UNION DISTINCT
  SELECT '61' AS lief_pal_typ_id,
   'Mix on GP_1 - GP_1 Anteil' AS lief_pal_typ_bez,
   'Mix on GP_1 - GP_1 Anteil' AS lief_pal_typ_bez_de,
   'Mix on GP_1 - GP_1 Anteil' AS lief_pal_typ_bez_cz,
   'Mix on GP_1 - GP_1 Anteil' AS lief_pal_typ_bez_sk,
   'Mix on GP_1 - GP_1 Anteil' AS lief_pal_typ_bez_hr,
   'Mix on GP_1 - GP_1 Anteil' AS lief_pal_typ_bez_pl,
   'Mix on GP_1 - GP_1 Anteil' AS lief_pal_typ_bez_ro,
   'Mix on GP_1 - GP_1 Anteil' AS lief_pal_typ_bez_bg
  FROM kfl_production_dbp_view.v_lief_pal_typ_spr_zu_1)
 UNION DISTINCT
 SELECT '64' AS lief_pal_typ_id,
  'Mix on GP_1 - MP Anteil' AS lief_pal_typ_bez,
  'Mix on GP_1 - MP Anteil' AS lief_pal_typ_bez_de,
  'Mix on GP_1 - MP Anteil' AS lief_pal_typ_bez_cz,
  'Mix on GP_1 - MP Anteil' AS lief_pal_typ_bez_sk,
  'Mix on GP_1 - MP Anteil' AS lief_pal_typ_bez_hr,
  'Mix on GP_1 - MP Anteil' AS lief_pal_typ_bez_pl,
  'Mix on GP_1 - MP Anteil' AS lief_pal_typ_bez_ro,
  'Mix on GP_1 - MP Anteil' AS lief_pal_typ_bez_bg
 FROM kfl_production_dbp_view.v_lief_pal_typ_spr_zu_1)
UNION DISTINCT
SELECT '' AS lief_pal_typ_id,
 '' AS lief_pal_typ_bez,
 '' AS lief_pal_typ_bez_de,
 '' AS lief_pal_typ_bez_cz,
 '' AS lief_pal_typ_bez_sk,
 '' AS lief_pal_typ_bez_hr,
 '' AS lief_pal_typ_bez_pl,
 '' AS lief_pal_typ_bez_ro,
 '' AS lief_pal_typ_bez_bg
FROM kfl_production_dbp_view.v_lief_pal_typ_spr_zu_1;