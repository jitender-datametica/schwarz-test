CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_artikelsortiment_spr_zu_1 (artikelsortiment_id,
artikelsortiment_bez, artikelsortiment_bez_de, artikelsortiment_bez_cz, artikelsortiment_bez_sk, artikelsortiment_bez_hr
, artikelsortiment_bez_pl, artikelsortiment_bez_ro, artikelsortiment_bez_bg) AS SELECT SUBSTR(CAST(artikelsortiment_id AS STRING)
  , 1, 2) AS artikelsortiment_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN artikelsortiment_bez
   ELSE NULL
   END) AS artikelsortiment_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN artikelsortiment_bez
   ELSE NULL
   END) AS artikelsortiment_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN artikelsortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN artikelsortiment_bez
    ELSE NULL
    END)) AS artikelsortiment_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN artikelsortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN artikelsortiment_bez
    ELSE NULL
    END)) AS artikelsortiment_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN artikelsortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN artikelsortiment_bez
    ELSE NULL
    END)) AS artikelsortiment_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN artikelsortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN artikelsortiment_bez
    ELSE NULL
    END)) AS artikelsortiment_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN artikelsortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN artikelsortiment_bez
    ELSE NULL
    END)) AS artikelsortiment_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN artikelsortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN artikelsortiment_bez
    ELSE NULL
    END)) AS artikelsortiment_bez_bg
FROM kfl_production_dbp_view.v_artikelsortiment_spr_zu_1 AS V01
GROUP BY V01.artikelsortiment_id
UNION DISTINCT
SELECT '-1' AS artikelsortiment_id,
 'N/A' AS artikelsortiment_bez,
 'N/A' AS artikelsortiment_bez_de,
 'N/A' AS artikelsortiment_bez_cz,
 'N/A' AS artikelsortiment_bez_sk,
 'N/A' AS artikelsortiment_bez_hr,
 'N/A' AS artikelsortiment_bez_pl,
 'N/A' AS artikelsortiment_bez_ro,
 'N/A' AS artikelsortiment_bez_bg
FROM kfl_production_dbp_view.v_artikelsortiment_spr_zu_1 AS V01
GROUP BY V01.artikelsortiment_id;