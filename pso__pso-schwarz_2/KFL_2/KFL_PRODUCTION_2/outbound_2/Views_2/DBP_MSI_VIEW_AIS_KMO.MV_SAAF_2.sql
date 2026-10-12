CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_saaf_2 (bewart_id, bewart_bez, bewart_bez_de, bewart_bez_cz
, bewart_bez_sk, bewart_bez_hr, bewart_bez_pl, bewart_bez_ro, bewart_bez_bg, mandant_id) AS SELECT bewart_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN bewart_bez
    ELSE NULL
    END), 'N/A') AS bewart_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN bewart_bez
    ELSE NULL
    END), 'N/A') AS bewart_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN bewart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN bewart_bez
     ELSE NULL
     END), 'N/A')) AS bewart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN bewart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN bewart_bez
     ELSE NULL
     END), 'N/A')) AS bewart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN bewart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN bewart_bez
     ELSE NULL
     END), 'N/A')) AS bewart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN bewart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN bewart_bez
     ELSE NULL
     END), 'N/A')) AS bewart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN bewart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN bewart_bez
     ELSE NULL
     END), 'N/A')) AS bewart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN bewart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN bewart_bez
     ELSE NULL
     END), 'N/A')) AS bewart_bez_bg,
 mandant_id
FROM kfl_production_dbp_view.v_bewart_spr_zu_2 AS V01
WHERE bewart_id IN (1001, 1002, 1010)
 AND mandant_id <> 1
GROUP BY bewart_id,
 mandant_id;