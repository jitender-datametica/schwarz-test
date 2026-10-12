CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_bestellart_spr_zu AS SELECT mandant_id,
 bestellart_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN bestellart_bez
   ELSE NULL
   END) AS bestellart_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN bestellart_bez
   ELSE NULL
   END) AS bestellart_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN bestellart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bestellart_bez
    ELSE NULL
    END)) AS bestellart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN bestellart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bestellart_bez
    ELSE NULL
    END)) AS bestellart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN bestellart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bestellart_bez
    ELSE NULL
    END)) AS bestellart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN bestellart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bestellart_bez
    ELSE NULL
    END)) AS bestellart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN bestellart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bestellart_bez
    ELSE NULL
    END)) AS bestellart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN bestellart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bestellart_bez
    ELSE NULL
    END)) AS bestellart_bez_bg
FROM kfl_production_dbp_view.v_bestellart_spr_zu
GROUP BY mandant_id,
 bestellart_id;