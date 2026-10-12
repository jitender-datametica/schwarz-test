CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_wg_int_spr_zu AS SELECT arthiertyp_id,
 wg_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN wg_bez
    ELSE NULL
    END), 'N/A') AS wg_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN wg_bez
    ELSE NULL
    END), 'N/A') AS wg_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wg_bez
     ELSE NULL
     END), 'N/A')) AS wg_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wg_bez
     ELSE NULL
     END), 'N/A')) AS wg_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wg_bez
     ELSE NULL
     END), 'N/A')) AS wg_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wg_bez
     ELSE NULL
     END), 'N/A')) AS wg_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wg_bez
     ELSE NULL
     END), 'N/A')) AS wg_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wg_bez
     ELSE NULL
     END), 'N/A')) AS wg_bez_bg
FROM kfl_production_dbp_view.v_wg_spr_zu AS WG
WHERE arthiertyp_id = 2
GROUP BY arthiertyp_id,
 wg_id;