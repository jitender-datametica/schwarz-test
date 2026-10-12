CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lager_bewart_spr_zu_prompt (lager_bewart_id, lager_bewart_bez
, lager_bewart_bez_de, lager_bewart_bez_cz, lager_bewart_bez_sk, lager_bewart_bez_hr, lager_bewart_bez_pl,
lager_bewart_bez_ro, lager_bewart_bez_bg) AS SELECT lager_bewart_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN lager_bewart_bez
   ELSE NULL
   END) AS lager_bewart_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN lager_bewart_bez
   ELSE NULL
   END) AS lager_bewart_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN lager_bewart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lager_bewart_bez
    ELSE NULL
    END)) AS lager_bewart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN lager_bewart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lager_bewart_bez
    ELSE NULL
    END)) AS lager_bewart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN lager_bewart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lager_bewart_bez
    ELSE NULL
    END)) AS lager_bewart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN lager_bewart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lager_bewart_bez
    ELSE NULL
    END)) AS lager_bewart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN lager_bewart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lager_bewart_bez
    ELSE NULL
    END)) AS lager_bewart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN lager_bewart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lager_bewart_bez
    ELSE NULL
    END)) AS lager_bewart_bez_bg
FROM kfl_production_dbp_view.v_lager_bewart_spr_zu AS V01
WHERE system_id NOT IN (2, 17, 28, 32, 48, 53)
GROUP BY lager_bewart_id;