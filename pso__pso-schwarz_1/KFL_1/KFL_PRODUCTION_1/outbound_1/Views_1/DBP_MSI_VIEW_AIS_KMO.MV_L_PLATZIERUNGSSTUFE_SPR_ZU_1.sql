CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_platzierungsstufe_spr_zu_1 (mandant_id,
platzierungsstufe_id, platzierungsstufe_bez, platzierungsstufe_bez_de, platzierungsstufe_bez_cz,
platzierungsstufe_bez_sk, platzierungsstufe_bez_hr, platzierungsstufe_bez_pl, platzierungsstufe_bez_ro,
platzierungsstufe_bez_bg) AS SELECT mandant_id,
 platzierungsstufe_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN platzierungsstufe_bez
    ELSE NULL
    END), 'N/A') AS platzierungsstufe_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN platzierungsstufe_bez
    ELSE NULL
    END), 'N/A') AS platzierungsstufe_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN platzierungsstufe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN platzierungsstufe_bez
     ELSE NULL
     END), 'N/A')) AS platzierungsstufe_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN platzierungsstufe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN platzierungsstufe_bez
     ELSE NULL
     END), 'N/A')) AS platzierungsstufe_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN platzierungsstufe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN platzierungsstufe_bez
     ELSE NULL
     END), 'N/A')) AS platzierungsstufe_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN platzierungsstufe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN platzierungsstufe_bez
     ELSE NULL
     END), 'N/A')) AS platzierungsstufe_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN platzierungsstufe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN platzierungsstufe_bez
     ELSE NULL
     END), 'N/A')) AS platzierungsstufe_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN platzierungsstufe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN platzierungsstufe_bez
     ELSE NULL
     END), 'N/A')) AS platzierungsstufe_bez_bg
FROM kfl_production_dbp_view.v_platzierungsstufe_spr_zu_1 AS V01
WHERE mandant_id <> 1
 AND (SUBSTR(platzierungsstufe_id, 1, 1) IN ('X', 'Y', 'Z') OR CAST(SUBSTR(platzierungsstufe_id, 3, 1) AS FLOAT64) = 0
    AND SUBSTR(platzierungsstufe_id, 1, 1) NOT IN ('X', 'Y', 'Z'))
GROUP BY mandant_id,
 platzierungsstufe_id;