CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_dim_projektrolle_spr_zu_2 (projektrolle_cd, projektrolle_bez,
projektrolle_bez_de, projektrolle_bez_cz, projektrolle_bez_sk, projektrolle_bez_hr, projektrolle_bez_pl,
projektrolle_bez_ro, projektrolle_bez_bg) AS SELECT projektrolle_cd,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN projektrolle_bez
    ELSE NULL
    END), 'N/A') AS projektrolle_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN projektrolle_bez
    ELSE NULL
    END), 'N/A') AS projektrolle_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN projektrolle_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN projektrolle_bez
     ELSE NULL
     END), 'N/A')) AS projektrolle_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN projektrolle_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN projektrolle_bez
     ELSE NULL
     END), 'N/A')) AS projektrolle_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN projektrolle_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN projektrolle_bez
     ELSE NULL
     END), 'N/A')) AS projektrolle_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN projektrolle_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN projektrolle_bez
     ELSE NULL
     END), 'N/A')) AS projektrolle_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN projektrolle_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN projektrolle_bez
     ELSE NULL
     END), 'N/A')) AS projektrolle_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN projektrolle_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN projektrolle_bez
     ELSE NULL
     END), 'N/A')) AS projektrolle_bez_bg
FROM kfl_production_dbp_data.projektrolle_spr_zu_2
GROUP BY projektrolle_cd;