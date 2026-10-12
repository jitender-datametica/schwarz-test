CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_owg_spr_zu (owg_id, arthiertyp_id, mandant_id, owg_bez,
owg_bez_de, owg_bez_cz, owg_bez_sk, owg_bez_hr, owg_bez_pl, owg_bez_ro, owg_bez_bg) AS SELECT owg_id,
 arthiertyp_id,
 mandant_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN owg_bez
    ELSE NULL
    END), 'N/A') AS owg_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN owg_bez
    ELSE NULL
    END), 'N/A') AS owg_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_bg
FROM kfl_production_dbp_view.v_owg_spr_zu AS V01
WHERE arthiertyp_id = 2
GROUP BY owg_id,
 arthiertyp_id,
 mandant_id;