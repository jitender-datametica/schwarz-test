CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_immobilie_spr_zu_1 (rpm_immobilie_id, dat_von,
rpm_immobilie_bez, rpm_immobilie_bez_cz, rpm_immobilie_bez_sk, rpm_immobilie_bez_hr, rpm_immobilie_bez_pl,
rpm_immobilie_bez_ro, rpm_immobilie_bez_en, rpm_immobilie_bez_bg) AS SELECT rpm_immobilie_id,
 dat_von,
 MAX(CASE
   WHEN spr_id = 22
   THEN rpm_immobilie_bez
   ELSE NULL
   END) AS rpm_immobilie_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN rpm_immobilie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_immobilie_bez
    ELSE NULL
    END)) AS rpm_immobilie_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN rpm_immobilie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_immobilie_bez
    ELSE NULL
    END)) AS rpm_immobilie_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN rpm_immobilie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_immobilie_bez
    ELSE NULL
    END)) AS rpm_immobilie_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN rpm_immobilie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_immobilie_bez
    ELSE NULL
    END)) AS rpm_immobilie_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN rpm_immobilie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_immobilie_bez
    ELSE NULL
    END)) AS rpm_immobilie_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN rpm_immobilie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_immobilie_bez
    ELSE NULL
    END)) AS rpm_immobilie_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN rpm_immobilie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_immobilie_bez
    ELSE NULL
    END)) AS rpm_immobilie_bez_bg
FROM kfl_production_dbp_view.v_rpm_immobilie_spr_zu_1 AS V01
GROUP BY rpm_immobilie_id,
 dat_von;