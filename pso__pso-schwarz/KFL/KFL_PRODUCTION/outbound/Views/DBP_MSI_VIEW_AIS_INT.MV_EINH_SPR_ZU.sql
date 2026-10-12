CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_einh_spr_zu (mandant_id, einh_id, einh_bez_kaufm,
einh_bez_kaufm_de, einh_bez_kaufm_cz, einh_bez_kaufm_sk, einh_bez_kaufm_hr, einh_bez_kaufm_pl, einh_bez_kaufm_ro,
einh_bez_kaufm_bg) AS SELECT mandant_id,
 einh_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN einh_bez_kaufm
    ELSE NULL
    END), 'N/A') AS einh_bez_kaufm,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN einh_bez_kaufm
    ELSE NULL
    END), 'N/A') AS einh_bez_kaufm_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN einh_bez_kaufm
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN einh_bez_kaufm
     ELSE NULL
     END), 'N/A')) AS einh_bez_kaufm_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN einh_bez_kaufm
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN einh_bez_kaufm
     ELSE NULL
     END), 'N/A')) AS einh_bez_kaufm_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN einh_bez_kaufm
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN einh_bez_kaufm
     ELSE NULL
     END), 'N/A')) AS einh_bez_kaufm_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN einh_bez_kaufm
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN einh_bez_kaufm
     ELSE NULL
     END), 'N/A')) AS einh_bez_kaufm_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN einh_bez_kaufm
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN einh_bez_kaufm
     ELSE NULL
     END), 'N/A')) AS einh_bez_kaufm_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN einh_bez_kaufm
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN einh_bez_kaufm
     ELSE NULL
     END), 'N/A')) AS einh_bez_kaufm_bg
FROM kfl_production_dbp_view.v_einh_spr_zu AS V01
GROUP BY mandant_id,
 einh_id;