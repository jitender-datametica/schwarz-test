CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_phase_spr_zu_1 AS SELECT rpm_phase_id,
 rpm_projekt_typ_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN rpm_phase_bez
   ELSE NULL
   END) AS rpm_phase_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN rpm_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_phase_bez
    ELSE NULL
    END)) AS rpm_phase_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN rpm_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_phase_bez
    ELSE NULL
    END)) AS rpm_phase_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN rpm_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_phase_bez
    ELSE NULL
    END)) AS rpm_phase_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN rpm_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_phase_bez
    ELSE NULL
    END)) AS rpm_phase_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN rpm_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_phase_bez
    ELSE NULL
    END)) AS rpm_phase_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN rpm_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_phase_bez
    ELSE NULL
    END)) AS rpm_phase_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN rpm_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rpm_phase_bez
    ELSE NULL
    END)) AS rpm_phase_bez_bg
FROM kfl_production_dbp_view.v_rpm_phase_spr_zu_1
GROUP BY rpm_phase_id,
 rpm_projekt_typ_id;