CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_in_wg_spr_zu_1 (mandant_id, in_wg_id, in_wg_bez, in_wg_bez_de,
in_wg_bez_cz, in_wg_bez_sk, in_wg_bez_hr, in_wg_bez_pl, in_wg_bez_ro, in_wg_bez_bg) AS SELECT mandant_id,
 in_wg_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN in_wg_bez
    ELSE NULL
    END), 'N/A') AS in_wg_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN in_wg_bez
    ELSE NULL
    END), 'N/A') AS in_wg_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN in_wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN in_wg_bez
     ELSE NULL
     END), 'N/A')) AS in_wg_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN in_wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN in_wg_bez
     ELSE NULL
     END), 'N/A')) AS in_wg_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN in_wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN in_wg_bez
     ELSE NULL
     END), 'N/A')) AS in_wg_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN in_wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN in_wg_bez
     ELSE NULL
     END), 'N/A')) AS in_in_wg_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN in_wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN in_wg_bez
     ELSE NULL
     END), 'N/A')) AS in_wg_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN in_wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN in_wg_bez
     ELSE NULL
     END), 'N/A')) AS in_wg_bez_bg
FROM kfl_production_dbp_data.in_wg_spr_zu_1
GROUP BY mandant_id,
 in_wg_id;