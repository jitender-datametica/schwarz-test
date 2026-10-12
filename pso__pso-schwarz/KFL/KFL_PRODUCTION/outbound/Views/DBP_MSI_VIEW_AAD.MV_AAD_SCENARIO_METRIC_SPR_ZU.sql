CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_aad_scenario_metric_spr_zu AS SELECT scenario_id,
 scenario_metric_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN scenario_metric_descr
    ELSE NULL
    END), 'N/A') AS scenario_metric_descr,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN scenario_metric_descr
    ELSE NULL
    END), 'N/A') AS scenario_metric_descr_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN scenario_metric_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN scenario_metric_descr
     ELSE NULL
     END), 'N/A')) AS scenario_metric_descr_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN scenario_metric_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN scenario_metric_descr
     ELSE NULL
     END), 'N/A')) AS scenario_metric_descr_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN scenario_metric_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN scenario_metric_descr
     ELSE NULL
     END), 'N/A')) AS scenario_metric_descr_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN scenario_metric_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN scenario_metric_descr
     ELSE NULL
     END), 'N/A')) AS scenario_metric_descr_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN scenario_metric_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN scenario_metric_descr
     ELSE NULL
     END), 'N/A')) AS scenario_metric_descr_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN scenario_metric_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN scenario_metric_descr
     ELSE NULL
     END), 'N/A')) AS scenario_metric_descr_bg
FROM kfl_production_dbp_view.v_aad_scenario_metric_spr_zu AS V01
GROUP BY scenario_id,
 scenario_metric_id;