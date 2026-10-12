CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wtag_spr_zu (wtag_id, wtag_bez, wtag_bez_de, wtag_bez_cz,
wtag_bez_sk, wtag_bez_hr, wtag_bez_pl, wtag_bez_ro, wtag_bez_bg) AS SELECT wtag_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END), 'N/A') AS wtag_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END), 'N/A') AS wtag_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN wtag_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wtag_bez
     ELSE NULL
     END), 'N/A')) AS wtag_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN wtag_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wtag_bez
     ELSE NULL
     END), 'N/A')) AS wtag_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN wtag_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wtag_bez
     ELSE NULL
     END), 'N/A')) AS wtag_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN wtag_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wtag_bez
     ELSE NULL
     END), 'N/A')) AS wtag_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN wtag_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wtag_bez
     ELSE NULL
     END), 'N/A')) AS wtag_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN wtag_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wtag_bez
     ELSE NULL
     END), 'N/A')) AS wtag_bez_bg
FROM kfl_production_dbp_view.v_wtag_spr_zu AS V01
GROUP BY wtag_id;