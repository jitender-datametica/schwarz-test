CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lager_bewgrund_spr_zu_hist_2 (mandant_id, grund_id,
lager_bewart_id, hist_fg, grund_bez, grund_bez_de, grund_bez_cz, grund_bez_sk, grund_bez_hr, grund_bez_pl, grund_bez_ro
, grund_bez_bg) AS SELECT mandant_id,
 grund_id,
 lager_bewart_id,
 MAX(hist_fg) AS hist_fg,
 MAX(CASE
   WHEN spr_id = 22
   THEN grund_bez
   ELSE NULL
   END) AS grund_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN grund_bez
   ELSE NULL
   END) AS grund_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN grund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN grund_bez
    ELSE NULL
    END)) AS grund_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN grund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN grund_bez
    ELSE NULL
    END)) AS grund_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN grund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN grund_bez
    ELSE NULL
    END)) AS grund_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN grund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN grund_bez
    ELSE NULL
    END)) AS grund_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN grund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN grund_bez
    ELSE NULL
    END)) AS grund_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN grund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN grund_bez
    ELSE NULL
    END)) AS grund_bez_bg
FROM kfl_production_dbp_view.v_lager_bewgrund_spr_zu_2 AS V01
WHERE hist_fg = 1
GROUP BY mandant_id,
 grund_id,
 lager_bewart_id;