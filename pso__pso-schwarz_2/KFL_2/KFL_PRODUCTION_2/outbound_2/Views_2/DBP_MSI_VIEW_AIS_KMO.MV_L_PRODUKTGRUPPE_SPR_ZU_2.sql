CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_produktgruppe_spr_zu_2 (mandant_id, produktgruppe_id,
produktgruppe_bez, produktgruppe_bez_de, produktgruppe_bez_cz, produktgruppe_bez_sk, produktgruppe_bez_hr,
produktgruppe_bez_pl, produktgruppe_bez_ro, produktgruppe_bez_bg) AS SELECT mandant_id,
 produktgruppe_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN produktgruppe_bez
    ELSE NULL
    END), 'N/A') AS produktgruppe_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN produktgruppe_bez
    ELSE NULL
    END), 'N/A') AS produktgruppe_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN produktgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN produktgruppe_bez
     ELSE NULL
     END), 'N/A')) AS produktgruppe_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN produktgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN produktgruppe_bez
     ELSE NULL
     END), 'N/A')) AS produktgruppe_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN produktgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN produktgruppe_bez
     ELSE NULL
     END), 'N/A')) AS produktgruppe_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN produktgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN produktgruppe_bez
     ELSE NULL
     END), 'N/A')) AS produktgruppe_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN produktgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN produktgruppe_bez
     ELSE NULL
     END), 'N/A')) AS produktgruppe_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN produktgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN produktgruppe_bez
     ELSE NULL
     END), 'N/A')) AS produktgruppe_bez_bg
FROM kfl_production_dbp_view.v_produktgruppe_spr_zu_2 AS V01
WHERE mandant_id <> 1
GROUP BY mandant_id,
 produktgruppe_id;