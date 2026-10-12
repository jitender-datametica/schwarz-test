CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_bedienkonzept_auspr_spr_zu_2 AS SELECT bedienkonzept_id,
 bedienkonzept_auspr_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN bedienkonzept_auspr_bez
   ELSE NULL
   END) AS bedienkonzept_auspr_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN bedienkonzept_auspr_bez
   ELSE NULL
   END) AS bedienkonzept_auspr_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN bedienkonzept_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS bedienkonzept_auspr_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN bedienkonzept_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS bedienkonzept_auspr_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN bedienkonzept_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS bedienkonzept_auspr_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN bedienkonzept_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS bedienkonzept_auspr_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN bedienkonzept_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS bedienkonzept_auspr_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN bedienkonzept_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS bedienkonzept_auspr_bez_bg
FROM kfl_production_dbp_view.v_bedienkonzept_auspr_spr_zu_2 AS V01
GROUP BY bedienkonzept_id,
 bedienkonzept_auspr_id;