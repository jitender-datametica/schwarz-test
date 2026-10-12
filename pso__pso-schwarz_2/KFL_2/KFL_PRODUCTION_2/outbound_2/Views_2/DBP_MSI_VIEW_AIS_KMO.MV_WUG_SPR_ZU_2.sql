CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wug_spr_zu_2 (mandant_id, wg_id, wug_id, arthiertyp_id,
wug_bez, wug_bez_de, wug_bez_cz, wug_bez_sk, wug_bez_hr, wug_bez_pl, wug_bez_ro, wug_bez_bg) AS SELECT mandant_id,
 wg_id,
 wug_id,
 arthiertyp_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN wug_bez
    ELSE NULL
    END), 'N/A') AS wug_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN wug_bez
    ELSE NULL
    END), 'N/A') AS wug_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_bg
FROM kfl_production_dbp_view.v_wug_spr_zu_2 AS V01
WHERE mandant_id <> 1
 AND arthiertyp_id = 2
GROUP BY mandant_id,
 wg_id,
 wug_id,
 arthiertyp_id;