CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_achsgruppe_spr_zu_1 (mandant_id, achsgruppe_id,
achsgruppe_bez, achsgruppe_bez_de, achsgruppe_bez_cz, achsgruppe_bez_sk, achsgruppe_bez_hr, achsgruppe_bez_pl,
achsgruppe_bez_ro, achsgruppe_bez_bg) AS SELECT mandant_id,
 achsgruppe_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN achsgruppe_bez
    ELSE NULL
    END), 'N/A') AS achsgruppe_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN achsgruppe_bez
    ELSE NULL
    END), 'N/A') AS achsgruppe_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN achsgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN achsgruppe_bez
     ELSE NULL
     END), 'N/A')) AS achsgruppe_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN achsgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN achsgruppe_bez
     ELSE NULL
     END), 'N/A')) AS achsgruppe_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN achsgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN achsgruppe_bez
     ELSE NULL
     END), 'N/A')) AS achsgruppe_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN achsgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN achsgruppe_bez
     ELSE NULL
     END), 'N/A')) AS achsgruppe_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN achsgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN achsgruppe_bez
     ELSE NULL
     END), 'N/A')) AS achsgruppe_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN achsgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN achsgruppe_bez
     ELSE NULL
     END), 'N/A')) AS achsgruppe_bez_bg
FROM kfl_production_dbp_view.v_achsgruppe_spr_zu_1 AS V01
WHERE mandant_id <> 1
GROUP BY mandant_id,
 achsgruppe_id;