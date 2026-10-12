CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bedienkonzept_spr_zu_2 AS SELECT V01.rpm_hierarchie_id AS
 rpm_immobilie_id,
 V01.bedienkonzept_id,
 V01.bedienkonzept_auspr_id,
 MAX(CASE
   WHEN V03.spr_id = 22
   THEN V03.bedienkonzept_auspr_bez
   ELSE NULL
   END) AS bedienkonzept_auspr_bez,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 124
    THEN V03.bedienkonzept_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS bedienkonzept_auspr_bez_cz,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 108
    THEN V03.bedienkonzept_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS bedienkonzept_auspr_bez_sk,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 65
    THEN V03.bedienkonzept_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS bedienkonzept_auspr_bez_hr,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 90
    THEN V03.bedienkonzept_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS bedienkonzept_auspr_bez_pl,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 95
    THEN V03.bedienkonzept_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS bedienkonzept_auspr_bez_ro,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 24
    THEN V03.bedienkonzept_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS bedienkonzept_auspr_bez_en,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 18
    THEN V03.bedienkonzept_auspr_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS bedienkonzept_auspr_bez_bg
FROM kfl_production_dbp_view.v_rpm_hier_bed_konzept_zu_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_bedienkonzept_auspr_spr_zu_2 AS V03 ON V01.bedienkonzept_id = V03.bedienkonzept_id
  AND V01.bedienkonzept_auspr_id = V03.bedienkonzept_auspr_id
GROUP BY rpm_immobilie_id,
 V01.bedienkonzept_id,
 V01.bedienkonzept_auspr_id;