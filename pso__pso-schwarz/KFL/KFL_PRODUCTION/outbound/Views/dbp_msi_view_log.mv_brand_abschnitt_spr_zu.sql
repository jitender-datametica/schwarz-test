CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_brand_abschnitt_spr_zu (mandant_id, lagernummer_id,
brand_abschnitt_id, brand_abschnitt_bez, brand_abschnitt_bez_de, brand_abschnitt_bez_cz, brand_abschnitt_bez_sk,
brand_abschnitt_bez_hr, brand_abschnitt_bez_pl, brand_abschnitt_bez_ro, brand_abschnitt_bez_bg) AS (SELECT mandant_id,
  lagernummer_id,
  brand_abschnitt_id,
  MAX(CASE
    WHEN spr_id = 22
    THEN brand_abschnitt_bez
    ELSE NULL
    END) AS brand_abschnitt_bez,
  MAX(CASE
    WHEN spr_id = 22
    THEN brand_abschnitt_bez
    ELSE NULL
    END) AS brand_abschnitt_bez_de,
  COALESCE(MAX(CASE
     WHEN spr_id = 124
     THEN brand_abschnitt_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN brand_abschnitt_bez
     ELSE NULL
     END)) AS brand_abschnitt_bez_cz,
  COALESCE(MAX(CASE
     WHEN spr_id = 108
     THEN brand_abschnitt_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN brand_abschnitt_bez
     ELSE NULL
     END)) AS brand_abschnitt_bez_sk,
  COALESCE(MAX(CASE
     WHEN spr_id = 65
     THEN brand_abschnitt_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN brand_abschnitt_bez
     ELSE NULL
     END)) AS brand_abschnitt_bez_hr,
  COALESCE(MAX(CASE
     WHEN spr_id = 90
     THEN brand_abschnitt_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN brand_abschnitt_bez
     ELSE NULL
     END)) AS brand_abschnitt_bez_pl,
  COALESCE(MAX(CASE
     WHEN spr_id = 95
     THEN brand_abschnitt_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN brand_abschnitt_bez
     ELSE NULL
     END)) AS brand_abschnitt_bez_ro,
  COALESCE(MAX(CASE
     WHEN spr_id = 18
     THEN brand_abschnitt_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN brand_abschnitt_bez
     ELSE NULL
     END)) AS brand_abschnitt_bez_bg
 FROM kfl_production_dbp_view.v_brand_abschnitt_spr_zu AS V01
 GROUP BY mandant_id,
  lagernummer_id,
  brand_abschnitt_id
 UNION DISTINCT
 SELECT mandant_id,
  lagernummer_id,
  '-1' AS brand_abschnitt_id,
  'system generated' AS brand_abschnitt_bez,
  'system generated' AS brand_abschnitt_bez_de,
  'system generated' AS brand_abschnitt_bez_cz,
  'system generated' AS brand_abschnitt_bez_sk,
  'system generated' AS brand_abschnitt_bez_hr,
  'system generated' AS brand_abschnitt_bez_pl,
  'system generated' AS brand_abschnitt_bez_ro,
  'system generated' AS brand_abschnitt_bez_bg
 FROM kfl_production_dbp_view.v_brand_abschnitt_spr_zu AS V01)
UNION DISTINCT
SELECT mandant_id,
 lagernummer_id,
 '  ' AS brand_abschnitt_id,
 'system generated' AS brand_abschnitt_bez,
 'system generated' AS brand_abschnitt_bez_de,
 'system generated' AS brand_abschnitt_bez_cz,
 'system generated' AS brand_abschnitt_bez_sk,
 'system generated' AS brand_abschnitt_bez_hr,
 'system generated' AS brand_abschnitt_bez_pl,
 'system generated' AS brand_abschnitt_bez_ro,
 'system generated' AS brand_abschnitt_bez_bg
FROM kfl_production_dbp_view.v_brand_abschnitt_spr_zu AS V01;