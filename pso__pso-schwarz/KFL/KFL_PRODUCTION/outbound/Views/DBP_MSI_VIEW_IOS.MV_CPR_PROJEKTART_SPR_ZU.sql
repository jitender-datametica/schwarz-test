CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_projektart_spr_zu (projektart_id, projektart_bez,
projektart_bez_cz, projektart_bez_sk, projektart_bez_hr, projektart_bez_pl, projektart_bez_ro, projektart_bez_en,
projektart_bez_bg) AS SELECT projektart_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN projektart_bez
   ELSE NULL
   END) AS projektart_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN projektart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN projektart_bez
    ELSE NULL
    END)) AS projektart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN projektart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN projektart_bez
    ELSE NULL
    END)) AS projektart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN projektart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN projektart_bez
    ELSE NULL
    END)) AS projektart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN projektart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN projektart_bez
    ELSE NULL
    END)) AS projektart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN projektart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN projektart_bez
    ELSE NULL
    END)) AS projektart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN projektart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN projektart_bez
    ELSE NULL
    END)) AS projektart_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN projektart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN projektart_bez
    ELSE NULL
    END)) AS projektart_bez_bg
FROM kfl_production_dbp_view.v_cpr_projektart_spr_zu
GROUP BY projektart_id;