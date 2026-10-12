CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_saison_spr_zu_2 (mandant_id, saison_id, saison_bez,
saison_bez_de, saison_bez_cz, saison_bez_sk, saison_bez_hr, saison_bez_pl, saison_bez_ro, saison_bez_bg) AS SELECT
 mandant_id,
 saison_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN saison_bez
    ELSE NULL
    END), 'N/A') AS saison_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN saison_bez
    ELSE NULL
    END), 'N/A') AS saison_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN saison_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN saison_bez
     ELSE NULL
     END), 'N/A')) AS saison_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN saison_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN saison_bez
     ELSE NULL
     END), 'N/A')) AS saison_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN saison_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN saison_bez
     ELSE NULL
     END), 'N/A')) AS saison_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN saison_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN saison_bez
     ELSE NULL
     END), 'N/A')) AS saison_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN saison_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN saison_bez
     ELSE NULL
     END), 'N/A')) AS saison_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN saison_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN saison_bez
     ELSE NULL
     END), 'N/A')) AS saison_bez_bg
FROM kfl_production_dbp_view.v_saison_spr_zu_2 AS V01
WHERE mandant_id <> 1
GROUP BY mandant_id,
 saison_id;