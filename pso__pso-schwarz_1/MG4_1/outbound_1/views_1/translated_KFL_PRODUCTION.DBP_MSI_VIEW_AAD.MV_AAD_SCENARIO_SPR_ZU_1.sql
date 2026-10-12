-- 20.06.2023 snik: SPEC0200569 AAD Scenario Sprachtabelle

CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_aad_scenario_spr_zu_1 (scenario_id, scenario_descr, scenario_descr_de,
scenario_descr_cz, scenario_descr_sk, scenario_descr_hr, scenario_descr_pl, scenario_descr_ro, scenario_descr_bg) AS
SELECT scenario_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN scenario_descr
    ELSE NULL
    END), 'N/A') AS scenario_descr,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN scenario_descr
    ELSE NULL
    END), 'N/A') AS scenario_descr_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN scenario_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN scenario_descr
     ELSE NULL
     END), 'N/A')) AS scenario_descr_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN scenario_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN scenario_descr
     ELSE NULL
     END), 'N/A')) AS scenario_descr_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN scenario_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN scenario_descr
     ELSE NULL
     END), 'N/A')) AS scenario_descr_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN scenario_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN scenario_descr
     ELSE NULL
     END), 'N/A')) AS scenario_descr_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN scenario_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN scenario_descr
     ELSE NULL
     END), 'N/A')) AS scenario_descr_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN scenario_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN scenario_descr
     ELSE NULL
     END), 'N/A')) AS scenario_descr_bg
FROM kfl_production_dbp_view.v_aad_scenario_spr_zu_1 AS v01
GROUP BY scenario_id;