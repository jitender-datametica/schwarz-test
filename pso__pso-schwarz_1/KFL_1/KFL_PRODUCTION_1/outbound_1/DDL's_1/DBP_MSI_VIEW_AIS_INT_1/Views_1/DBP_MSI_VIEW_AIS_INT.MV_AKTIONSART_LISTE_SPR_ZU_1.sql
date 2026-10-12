CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_aktionsart_liste_spr_zu_1 (mandant_id, aktionsart_liste_id,
aktionsart_liste_bez, aktionsart_liste_bez_de, aktionsart_liste_bez_cz, aktionsart_liste_bez_sk, aktionsart_liste_bez_hr
, aktionsart_liste_bez_pl, aktionsart_liste_bez_ro, aktionsart_liste_bez_bg) AS SELECT mandant_id,
 aktionsart_liste_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN aktionsart_liste_bez
    ELSE NULL
    END), 'N/A') AS aktionsart_liste_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN aktionsart_liste_bez
    ELSE NULL
    END), 'N/A') AS aktionsart_liste_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN aktionsart_liste_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktionsart_liste_bez
     ELSE NULL
     END), 'N/A')) AS aktionsart_liste_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN aktionsart_liste_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktionsart_liste_bez
     ELSE NULL
     END), 'N/A')) AS aktionsart_liste_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN aktionsart_liste_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktionsart_liste_bez
     ELSE NULL
     END), 'N/A')) AS aktionsart_liste_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN aktionsart_liste_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktionsart_liste_bez
     ELSE NULL
     END), 'N/A')) AS aktionsart_liste_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN aktionsart_liste_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktionsart_liste_bez
     ELSE NULL
     END), 'N/A')) AS aktionsart_liste_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN aktionsart_liste_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktionsart_liste_bez
     ELSE NULL
     END), 'N/A')) AS aktionsart_liste_bez_bg
FROM kfl_production_dbp_view.v_aktionsart_liste_spr_zu_1
GROUP BY mandant_id,
 aktionsart_liste_id;