CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_temperatur_spr_zu_1 (mandant_id, temperatur_id,
temperatur_bez, temperatur_bez_de, temperatur_bez_cz, temperatur_bez_sk, temperatur_bez_hr, temperatur_bez_pl,
temperatur_bez_ro, temperatur_bez_bg) AS SELECT mandant_id,
 temperatur_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN temperatur_bez
    ELSE NULL
    END), 'N/A') AS temperatur_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN temperatur_bez
    ELSE NULL
    END), 'N/A') AS temperatur_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN temperatur_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN temperatur_bez
     ELSE NULL
     END), 'N/A')) AS temperatur_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN temperatur_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN temperatur_bez
     ELSE NULL
     END), 'N/A')) AS temperatur_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN temperatur_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN temperatur_bez
     ELSE NULL
     END), 'N/A')) AS temperatur_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN temperatur_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN temperatur_bez
     ELSE NULL
     END), 'N/A')) AS temperatur_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN temperatur_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN temperatur_bez
     ELSE NULL
     END), 'N/A')) AS temperatur_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN temperatur_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN temperatur_bez
     ELSE NULL
     END), 'N/A')) AS temperatur_bez_bg
FROM kfl_production_dbp_view.v_temperatur_spr_zu_1 AS V01
GROUP BY mandant_id,
 temperatur_id;