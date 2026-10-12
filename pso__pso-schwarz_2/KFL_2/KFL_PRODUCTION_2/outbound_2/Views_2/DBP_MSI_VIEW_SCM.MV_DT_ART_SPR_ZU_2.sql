CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_scm.mv_dt_art_spr_zu_2
OPTIONS(enable_refresh = TRUE, refresh_interval_minutes = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT mandant_id,
 art_id,
 MAX(CASE
   WHEN art_id = - 1
   THEN 'Alle (DIF)'
   WHEN spr_id = 22
   THEN art_bez
   ELSE NULL
   END) AS art_bez,
 MAX(CASE
   WHEN art_id = - 1
   THEN 'Alle (DIF)'
   WHEN spr_id = 22
   THEN art_bez
   ELSE NULL
   END) AS art_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN art_id = - 1
    THEN 'Alle (DIF)'
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END)) AS art_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN art_id = - 1
    THEN 'Alle (DIF)'
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END)) AS art_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN art_id = - 1
    THEN 'Alle (DIF)'
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END)) AS art_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN art_id = - 1
    THEN 'Alle (DIF)'
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END)) AS art_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN art_id = - 1
    THEN 'Alle (DIF)'
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END)) AS art_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN art_id = - 1
    THEN 'Alle (DIF)'
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END)) AS art_bez_bg
FROM kfl_production_dbp_view.v_art_spr_zu_2 AS V01
GROUP BY mandant_id,
 art_id
UNION DISTINCT
SELECT mandant_id,
 - 3 AS art_id,
 'n/a' AS art_bez,
 'n/a' AS art_bez_de,
 'n/a' AS art_bez_cz,
 'n/a' AS art_bez_sk,
 'n/a' AS art_bez_hr,
 'n/a' AS art_bez_pl,
 'n/a' AS art_bez_ro,
 'n/a' AS art_bez_bg
FROM kfl_production_dbp_view.v_mandant_2 AS V01
GROUP BY mandant_id;