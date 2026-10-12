CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_fin_kategorie_spr_zu_1 AS SELECT fin_kategorie_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN fin_kategorie_bez
   ELSE NULL
   END) AS fin_kategorie_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN fin_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN fin_kategorie_bez
    ELSE NULL
    END)) AS fin_kategorie_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN fin_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN fin_kategorie_bez
    ELSE NULL
    END)) AS fin_kategorie_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN fin_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN fin_kategorie_bez
    ELSE NULL
    END)) AS fin_kategorie_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN fin_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN fin_kategorie_bez
    ELSE NULL
    END)) AS fin_kategorie_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN fin_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN fin_kategorie_bez
    ELSE NULL
    END)) AS fin_kategorie_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN fin_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN fin_kategorie_bez
    ELSE NULL
    END)) AS fin_kategorie_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN fin_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN fin_kategorie_bez
    ELSE NULL
    END)) AS fin_kategorie_bez_bg
FROM kfl_production_dbp_view.v_rpm_fin_kategorie_spr_zu_1 AS V03
GROUP BY fin_kategorie_id;