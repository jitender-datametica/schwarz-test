CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_ginfo_bauform_spr_zu (ginfo_bauform_id, ginfo_bauform_bez,
ginfo_bauform_bez_cz, ginfo_bauform_bez_sk, ginfo_bauform_bez_hr, ginfo_bauform_bez_pl, ginfo_bauform_bez_ro,
ginfo_bauform_bez_en, ginfo_bauform_bez_bg) AS SELECT ginfo_bauform_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ginfo_bauform_bez
   ELSE NULL
   END) AS ginfo_bauform_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN ginfo_bauform_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ginfo_bauform_bez
    ELSE NULL
    END)) AS ginfo_bauform_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN ginfo_bauform_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ginfo_bauform_bez
    ELSE NULL
    END)) AS ginfo_bauform_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN ginfo_bauform_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ginfo_bauform_bez
    ELSE NULL
    END)) AS ginfo_bauform_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN ginfo_bauform_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ginfo_bauform_bez
    ELSE NULL
    END)) AS ginfo_bauform_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN ginfo_bauform_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ginfo_bauform_bez
    ELSE NULL
    END)) AS ginfo_bauform_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN ginfo_bauform_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ginfo_bauform_bez
    ELSE NULL
    END)) AS ginfo_bauform_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN ginfo_bauform_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ginfo_bauform_bez
    ELSE NULL
    END)) AS ginfo_bauform_bez_bg
FROM kfl_production_dbp_view.v_ginfo_bauform_spr_zu
GROUP BY ginfo_bauform_id;