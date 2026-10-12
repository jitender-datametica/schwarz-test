CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_bestellart_spr_zu_prompt_1 (bestellart_id, bestellart_bez,
bestellart_bez_de, bestellart_bez_cz, bestellart_bez_sk, bestellart_bez_hr, bestellart_bez_pl, bestellart_bez_ro,
bestellart_bez_bg) AS SELECT bestellart_id,
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
FROM kfl_production_dbp_view.v_bestellart_spr_zu_1 AS V01
GROUP BY bestellart_id
UNION DISTINCT
SELECT '-2' AS bestellart_id,
 'n/a' AS bestellart_bez,
 'n/a' AS bestellart_bez_de,
 'n/a' AS bestellart_bez_cz,
 'n/a' AS bestellart_bez_sk,
 'n/a' AS bestellart_bez_hr,
 'n/a' AS bestellart_bez_pl,
 'n/a' AS bestellart_bez_ro,
 'n/a' AS bestellart_bez_bg;