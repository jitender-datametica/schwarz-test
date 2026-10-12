CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_wtag_spr_zu_2 AS SELECT wtag_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN wtag_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END)) AS wtag_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN wtag_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END)) AS wtag_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN wtag_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END)) AS wtag_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN wtag_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END)) AS wtag_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN wtag_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END)) AS wtag_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN wtag_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END)) AS wtag_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN wtag_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END)) AS wtag_bez_bg
FROM kfl_production_dbp_view.v_wtag_spr_zu_2 AS V01
GROUP BY wtag_id;