CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_art_spr_zu_1 AS SELECT mandant_id,
 art_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END), 'N/A') AS art_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END), 'N/A') AS art_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN art_bez
     ELSE NULL
     END), 'N/A')) AS art_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN art_bez
     ELSE NULL
     END), 'N/A')) AS art_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN art_bez
     ELSE NULL
     END), 'N/A')) AS art_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN art_bez
     ELSE NULL
     END), 'N/A')) AS art_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN art_bez
     ELSE NULL
     END), 'N/A')) AS art_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN art_bez
     ELSE NULL
     END), 'N/A')) AS art_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN art_bez
     ELSE NULL
     END), 'N/A')) AS art_bez_bg
FROM kfl_production_dbp_view.v_art_spr_zu_1 AS V01
GROUP BY mandant_id,
 art_id;