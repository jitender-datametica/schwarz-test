CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_art_spr_zu (mandant_id, art_id, art_bez,
art_bez_de, art_bez_cz, art_bez_sk, art_bez_hr, art_bez_pl, art_bez_ro, art_bez_bg) AS SELECT mandant_id,
 art_id,
 MAX(CASE
   WHEN art_id = -1
   THEN 'Alle (DIF)'
   WHEN spr_id = 22
   THEN art_bez
   ELSE NULL
   END) AS art_bez,
 MAX(CASE
   WHEN art_id = -1
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
    WHEN art_id = -1
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
    WHEN art_id = -1
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
    WHEN art_id = -1
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
    WHEN art_id = -1
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
    WHEN art_id = -1
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
    WHEN art_id = -1
    THEN 'Alle (DIF)'
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END)) AS art_bez_bg
FROM kfl_production_dbp_view.v_art_spr_zu AS V01
GROUP BY mandant_id,
 art_id
UNION DISTINCT
SELECT mandant_id,
 -3 AS art_id,
 'n/a' AS art_bez,
 'n/a' AS art_bez_de,
 'n/a' AS art_bez_cz,
 'n/a' AS art_bez_sk,
 'n/a' AS art_bez_hr,
 'n/a' AS art_bez_pl,
 'n/a' AS art_bez_ro,
 'n/a' AS art_bez_bg
FROM kfl_production_dbp_view.v_mandant AS V01
GROUP BY mandant_id;