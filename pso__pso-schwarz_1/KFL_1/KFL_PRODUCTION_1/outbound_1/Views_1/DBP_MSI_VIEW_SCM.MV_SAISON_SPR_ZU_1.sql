CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_saison_spr_zu_1 AS SELECT mandant_id,
 saison_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN saison_bez
   ELSE NULL
   END) AS saison_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN saison_bez
   ELSE NULL
   END) AS saison_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN saison_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN saison_bez
    ELSE NULL
    END)) AS saison_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN saison_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN saison_bez
    ELSE NULL
    END)) AS saison_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN saison_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN saison_bez
    ELSE NULL
    END)) AS saison_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN saison_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN saison_bez
    ELSE NULL
    END)) AS saison_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN saison_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN saison_bez
    ELSE NULL
    END)) AS saison_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN saison_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN saison_bez
    ELSE NULL
    END)) AS saison_bez_bg
FROM kfl_production_dbp_view.v_saison_spr_zu_1
WHERE saison_id <> ''
GROUP BY mandant_id,
 saison_id
UNION ALL
SELECT mandant_id,
 saison_id,
 'leer/empty' AS saison_bez,
 'leer/empty' AS saison_bez_de,
 'leer/empty' AS saison_bez_cz,
 'leer/empty' AS saison_bez_sk,
 'leer/empty' AS saison_bez_hr,
 'leer/empty' AS saison_bez_pl,
 'leer/empty' AS saison_bez_ro,
 'leer/empty' AS saison_bez_bg
FROM kfl_production_dbp_view.v_saison_spr_zu_1
WHERE saison_id = ''
GROUP BY mandant_id,
 saison_id;