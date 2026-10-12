CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_fin_plantyp_spr_zu_2 AS SELECT V01.rpm_plantyp_id,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN V02.rpm_plantyp_bez
   ELSE NULL
   END) AS rpm_plantyp_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.rpm_plantyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_plantyp_bez
    ELSE NULL
    END)) AS rpm_plantyp_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.rpm_plantyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_plantyp_bez
    ELSE NULL
    END)) AS rpm_plantyp_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.rpm_plantyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_plantyp_bez
    ELSE NULL
    END)) AS rpm_plantyp_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.rpm_plantyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_plantyp_bez
    ELSE NULL
    END)) AS rpm_plantyp_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.rpm_plantyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_plantyp_bez
    ELSE NULL
    END)) AS rpm_plantyp_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN V02.rpm_plantyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_plantyp_bez
    ELSE NULL
    END)) AS rpm_plantyp_bez_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.rpm_plantyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.rpm_plantyp_bez
    ELSE NULL
    END)) AS rpm_plantyp_bez_bg
FROM kfl_production_dbp_view.v_l_rpm_plantyp_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_rpm_plantyp_spr_zu_2 AS V02 ON V01.rpm_plantyp_id = V02.rpm_plantyp_id
GROUP BY V01.rpm_plantyp_id;