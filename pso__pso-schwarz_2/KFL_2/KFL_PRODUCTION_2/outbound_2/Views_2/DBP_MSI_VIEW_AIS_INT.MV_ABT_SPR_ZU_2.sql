CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_abt_spr_zu_2 (mandant_id, abt_id, arthiertyp_id, abt_bez,
abt_bez_de, abt_bez_cz, abt_bez_sk, abt_bez_hr, abt_bez_pl, abt_bez_ro, abt_bez_bg) AS SELECT mandant_id,
 abt_id,
 arthiertyp_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN abt_bez
    ELSE NULL
    END), 'N/A') AS abt_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN abt_bez
    ELSE NULL
    END), 'N/A') AS abt_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN abt_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN abt_bez
     ELSE NULL
     END), 'N/A')) AS abt_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN abt_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN abt_bez
     ELSE NULL
     END), 'N/A')) AS abt_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN abt_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN abt_bez
     ELSE NULL
     END), 'N/A')) AS abt_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN abt_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN abt_bez
     ELSE NULL
     END), 'N/A')) AS abt_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN abt_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN abt_bez
     ELSE NULL
     END), 'N/A')) AS abt_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN abt_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN abt_bez
     ELSE NULL
     END), 'N/A')) AS abt_bez_bg
FROM kfl_production_dbp_view.v_abt_spr_zu_2 AS V01
WHERE arthiertyp_id = 2
GROUP BY mandant_id,
 abt_id,
 arthiertyp_id;