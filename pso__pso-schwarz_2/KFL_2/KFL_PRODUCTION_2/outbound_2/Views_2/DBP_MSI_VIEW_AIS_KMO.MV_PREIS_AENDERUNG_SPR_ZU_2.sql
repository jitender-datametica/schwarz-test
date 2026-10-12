CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_preis_aenderung_spr_zu_2 (mandant_id, preis_aend_grund_id,
preis_aend_grund_bez, preis_aend_grund_bez_de, preis_aend_grund_bez_cz, preis_aend_grund_bez_sk, preis_aend_grund_bez_hr
, preis_aend_grund_bez_pl, preis_aend_grund_bez_ro, preis_aend_grund_bez_bg) AS SELECT mandant_id,
 preis_aend_grund_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN preis_aend_grund_bez
    ELSE NULL
    END), 'N/A') AS preis_aend_grund_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN preis_aend_grund_bez
    ELSE NULL
    END), 'N/A') AS preis_aend_grund_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN preis_aend_grund_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN preis_aend_grund_bez
     ELSE NULL
     END), 'N/A')) AS preis_aend_grund_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN preis_aend_grund_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN preis_aend_grund_bez
     ELSE NULL
     END), 'N/A')) AS preis_aend_grund_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN preis_aend_grund_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN preis_aend_grund_bez
     ELSE NULL
     END), 'N/A')) AS preis_aend_grund_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN preis_aend_grund_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN preis_aend_grund_bez
     ELSE NULL
     END), 'N/A')) AS preis_aend_grund_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN preis_aend_grund_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN preis_aend_grund_bez
     ELSE NULL
     END), 'N/A')) AS preis_aend_grund_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN preis_aend_grund_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN preis_aend_grund_bez
     ELSE NULL
     END), 'N/A')) AS preis_aend_grund_bez_bg
FROM kfl_production_dbp_view.v_preis_aenderung_spr_zu_2 AS V01
WHERE mandant_id <> 1
 AND (preis_aend_grund_id <> 7 OR mandant_id NOT IN (3, 6))
GROUP BY mandant_id,
 preis_aend_grund_id;