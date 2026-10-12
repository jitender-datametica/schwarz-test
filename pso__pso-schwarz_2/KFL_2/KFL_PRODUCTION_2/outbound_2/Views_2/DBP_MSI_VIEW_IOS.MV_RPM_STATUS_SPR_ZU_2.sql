CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_status_spr_zu_2 (rpm_status_id, rpm_status_bez,
rpm_status_bez_cz, rpm_status_bez_sk, rpm_status_bez_hr, rpm_status_bez_pl, rpm_status_bez_ro, rpm_status_bez_en,
rpm_status_bez_bg) AS SELECT rpm_status_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN rpm_status_bez
   ELSE NULL
   END) AS rpm_status_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN rpm_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_status_bez
    ELSE NULL
    END)) AS rpm_status_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN rpm_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_status_bez
    ELSE NULL
    END)) AS rpm_status_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN rpm_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_status_bez
    ELSE NULL
    END)) AS rpm_status_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN rpm_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_status_bez
    ELSE NULL
    END)) AS rpm_status_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN rpm_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_status_bez
    ELSE NULL
    END)) AS rpm_status_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN rpm_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_status_bez
    ELSE NULL
    END)) AS rpm_status_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN rpm_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_status_bez
    ELSE NULL
    END)) AS rpm_status_bez_bg
FROM kfl_production_dbp_view.v_rpm_status_spr_zu_2 AS V01
GROUP BY rpm_status_id;