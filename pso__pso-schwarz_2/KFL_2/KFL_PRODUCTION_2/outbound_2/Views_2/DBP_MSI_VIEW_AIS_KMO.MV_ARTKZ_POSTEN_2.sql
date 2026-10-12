CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artkz_posten_2 (mandant_id, posten_id, posten_bez,
posten_bez_de, posten_bez_cz, posten_bez_sk, posten_bez_hr, posten_bez_pl, posten_bez_ro, posten_bez_bg) AS SELECT
 mandant_id,
 posten_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN posten_bez
    ELSE NULL
    END), 'N/A') AS posten_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN posten_bez
    ELSE NULL
    END), 'N/A') AS posten_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN posten_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN posten_bez
     ELSE NULL
     END), 'N/A')) AS posten_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN posten_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN posten_bez
     ELSE NULL
     END), 'N/A')) AS posten_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN posten_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN posten_bez
     ELSE NULL
     END), 'N/A')) AS posten_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN posten_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN posten_bez
     ELSE NULL
     END), 'N/A')) AS posten_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN posten_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN posten_bez
     ELSE NULL
     END), 'N/A')) AS posten_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN posten_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN posten_bez
     ELSE NULL
     END), 'N/A')) AS posten_bez_bg
FROM kfl_production_dbp_view.v_artkz_posten_2 AS V01
WHERE mandant_id <> 1
GROUP BY mandant_id,
 posten_id;