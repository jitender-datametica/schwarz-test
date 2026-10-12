CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_kostenart_spr_zu (mandant_id, kostenart_id, krk_id,
kostenart_bez, kostenart_bez_de, kostenart_bez_cz, kostenart_bez_sk, kostenart_bez_hr, kostenart_bez_pl,
kostenart_bez_ro, kostenart_bez_bg) AS SELECT mandant_id,
 RIGHT(kostenart_id, 6) AS kostenart_id,
 krk_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN kostenart_bez
    ELSE NULL
    END), 'N/A') AS kostenart_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN kostenart_bez
    ELSE NULL
    END), 'N/A') AS kostenart_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN kostenart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kostenart_bez
     ELSE NULL
     END), 'N/A')) AS kostenart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN kostenart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kostenart_bez
     ELSE NULL
     END), 'N/A')) AS kostenart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN kostenart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kostenart_bez
     ELSE NULL
     END), 'N/A')) AS kostenart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN kostenart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kostenart_bez
     ELSE NULL
     END), 'N/A')) AS kostenart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN kostenart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kostenart_bez
     ELSE NULL
     END), 'N/A')) AS kostenart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN kostenart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kostenart_bez
     ELSE NULL
     END), 'N/A')) AS kostenart_bez_bg
FROM kfl_production_dbp_data.kostenart_spr_zu
GROUP BY mandant_id,
 kostenart_id,
 krk_id;