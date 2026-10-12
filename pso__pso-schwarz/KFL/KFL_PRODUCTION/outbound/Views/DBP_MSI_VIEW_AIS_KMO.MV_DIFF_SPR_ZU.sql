CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_diff_spr_zu (mandant_id, diff_id, diff_bez, diff_bez_de,
diff_bez_cz, diff_bez_sk, diff_bez_hr, diff_bez_pl, diff_bez_ro, diff_bez_bg) AS SELECT mandant_id,
 diff_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN diff_bez
    ELSE NULL
    END), 'N/A') AS diff_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN diff_bez
    ELSE NULL
    END), 'N/A') AS diff_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN diff_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN diff_bez
     ELSE NULL
     END), 'N/A')) AS diff_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN diff_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN diff_bez
     ELSE NULL
     END), 'N/A')) AS diff_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN diff_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN diff_bez
     ELSE NULL
     END), 'N/A')) AS diff_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN diff_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN diff_bez
     ELSE NULL
     END), 'N/A')) AS diff_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN diff_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN diff_bez
     ELSE NULL
     END), 'N/A')) AS diff_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN diff_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN diff_bez
     ELSE NULL
     END), 'N/A')) AS diff_bez_bg
FROM kfl_production_dbp_view.v_diff_spr_zu AS V01
WHERE mandant_id <> 1
GROUP BY mandant_id,
 diff_id;