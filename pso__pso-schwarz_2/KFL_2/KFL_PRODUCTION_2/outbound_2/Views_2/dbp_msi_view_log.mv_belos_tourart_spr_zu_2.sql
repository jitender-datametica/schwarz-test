CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_belos_tourart_spr_zu_2 (belos_tourart_id, belos_tourart_bez,
belos_tourart_bez_de, belos_tourart_bez_cz, belos_tourart_bez_sk, belos_tourart_bez_hr, belos_tourart_bez_pl,
belos_tourart_bez_ro, belos_tourart_bez_b) AS SELECT belos_tourart_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN belos_tourart_bez
   ELSE NULL
   END) AS belos_tourart_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN belos_tourart_bez
   ELSE NULL
   END) AS belos_tourart_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN belos_tourart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN belos_tourart_bez
    ELSE NULL
    END)) AS belos_tourart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN belos_tourart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN belos_tourart_bez
    ELSE NULL
    END)) AS belos_tourart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN belos_tourart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN belos_tourart_bez
    ELSE NULL
    END)) AS belos_tourart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN belos_tourart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN belos_tourart_bez
    ELSE NULL
    END)) AS belos_tourart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN belos_tourart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN belos_tourart_bez
    ELSE NULL
    END)) AS belos_tourart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN belos_tourart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN belos_tourart_bez
    ELSE NULL
    END)) AS belos_tourart_bez_bg
FROM kfl_production_dbp_view.v_belos_tourart_spr_zu_2 AS V01
GROUP BY belos_tourart_id;