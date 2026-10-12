-- 10.07.2023 snik: SPEC0202038 WG SPR_ZU
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_wg_int_spr_zu (arthiertyp_id,
wg_id, wg_bez, wg_bez_de, wg_bez_cz, wg_bez_sk, wg_bez_hr, wg_bez_pl, wg_bez_ro, wg_bez_bg) AS SELECT arthiertyp_id,
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
FROM kfl_production_dbp_view.v_wg_spr_zu AS wg
WHERE arthiertyp_id = 2
GROUP BY arthiertyp_id,
 wg_id;