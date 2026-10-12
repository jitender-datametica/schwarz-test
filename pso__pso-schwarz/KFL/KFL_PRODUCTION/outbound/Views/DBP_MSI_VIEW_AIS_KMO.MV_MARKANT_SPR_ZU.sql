CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_markant_spr_zu (mandant_id, markant_id, markant_bez,
markant_bez_de, markant_bez_cz, markant_bez_sk, markant_bez_hr, markant_bez_pl, markant_bez_ro, markant_bez_bg) AS
SELECT mandant_id,
 markant_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN markant_bez
    ELSE NULL
    END), 'N/A') AS markant_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN markant_bez
    ELSE NULL
    END), 'N/A') AS markant_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN markant_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN markant_bez
     ELSE NULL
     END), 'N/A')) AS markant_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN markant_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN markant_bez
     ELSE NULL
     END), 'N/A')) AS markant_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN markant_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN markant_bez
     ELSE NULL
     END), 'N/A')) AS markant_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN markant_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN markant_bez
     ELSE NULL
     END), 'N/A')) AS markant_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN markant_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN markant_bez
     ELSE NULL
     END), 'N/A')) AS markant_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN markant_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN markant_bez
     ELSE NULL
     END), 'N/A')) AS markant_bez_bg
FROM kfl_production_dbp_view.v_markant_spr_zu AS V01
WHERE mandant_id <> 1
GROUP BY mandant_id,
 markant_id;