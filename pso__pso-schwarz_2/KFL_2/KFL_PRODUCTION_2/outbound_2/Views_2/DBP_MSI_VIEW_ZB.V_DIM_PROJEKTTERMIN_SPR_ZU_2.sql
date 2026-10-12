CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_dim_projekttermin_spr_zu_2 (projekttermin_cd, projekttermin_bez,
projekttermin_bez_de, projekttermin_bez_cz, projekttermin_bez_sk, projekttermin_bez_hr, projekttermin_bez_pl,
projekttermin_bez_ro, projekttermin_bez_bg) AS SELECT projekttermin_cd,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN projekttermin_bez
    ELSE NULL
    END), 'N/A') AS projekttermin_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN projekttermin_bez
    ELSE NULL
    END), 'N/A') AS projekttermin_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN projekttermin_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN projekttermin_bez
     ELSE NULL
     END), 'N/A')) AS projekttermin_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN projekttermin_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN projekttermin_bez
     ELSE NULL
     END), 'N/A')) AS projekttermin_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN projekttermin_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN projekttermin_bez
     ELSE NULL
     END), 'N/A')) AS projekttermin_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN projekttermin_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN projekttermin_bez
     ELSE NULL
     END), 'N/A')) AS projekttermin_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN projekttermin_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN projekttermin_bez
     ELSE NULL
     END), 'N/A')) AS projekttermin_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN projekttermin_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN projekttermin_bez
     ELSE NULL
     END), 'N/A')) AS projekttermin_bez_bg
FROM kfl_production_dbp_data.projekttermin_spr_zu_2
GROUP BY projekttermin_cd;