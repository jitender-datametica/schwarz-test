CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_anlass_spr_zu_1 AS SELECT projekt_anlass_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN projekt_anlass_bez
   ELSE NULL
   END) AS projekt_anlass_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN projekt_anlass_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN projekt_anlass_bez
    ELSE NULL
    END)) AS projekt_anlass_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN projekt_anlass_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN projekt_anlass_bez
    ELSE NULL
    END)) AS projekt_anlass_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN projekt_anlass_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN projekt_anlass_bez
    ELSE NULL
    END)) AS projekt_anlass_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN projekt_anlass_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN projekt_anlass_bez
    ELSE NULL
    END)) AS projekt_anlass_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN projekt_anlass_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN projekt_anlass_bez
    ELSE NULL
    END)) AS projekt_anlass_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN projekt_anlass_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN projekt_anlass_bez
    ELSE NULL
    END)) AS projekt_anlass_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN projekt_anlass_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN projekt_anlass_bez
    ELSE NULL
    END)) AS projekt_anlass_bez_bg
FROM kfl_production_dbp_view.v_cpr_anlass_spr_zu_1 AS V01
GROUP BY projekt_anlass_id;