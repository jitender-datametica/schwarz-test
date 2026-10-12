CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_phasenart_spr_zu_1 (phasenart_id, cpr_phase_bez,
cpr_phase_bez_cz, cpr_phase_bez_sk, cpr_phase_bez_hr, cpr_phase_bez_pl, cpr_phase_bez_ro, cpr_phase_bez_en,
cpr_phase_bez_bg) AS SELECT phasenart_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN cpr_phase_bez
   ELSE NULL
   END) AS cpr_phase_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_bg
FROM kfl_production_dbp_view.v_phasenart_spr_zu_1
GROUP BY phasenart_id;