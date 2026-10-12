CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lager_bewart_typ_spr_zu (mandant_id, lager_bewart_typ_id,
hist_fg, lager_bewart_typ_bez, lager_bewart_typ_bez_de, lager_bewart_typ_bez_cz, lager_bewart_typ_bez_sk,
lager_bewart_typ_bez_hr, lager_bewart_typ_bez_pl, lager_bewart_typ_bez_ro, lager_bewart_typ_bez_bg) AS SELECT mandant_id
 ,
 lager_bewart_typ_id,
 MAX(hist_fg) AS hist_fg,
 MAX(CASE
   WHEN spr_id = 22
   THEN lager_bewart_typ_bez
   ELSE NULL
   END) AS lager_bewart_typ_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN lager_bewart_typ_bez
   ELSE NULL
   END) AS lager_bewart_typ_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN lager_bewart_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lager_bewart_typ_bez
    ELSE NULL
    END)) AS lager_bewart_typ_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN lager_bewart_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lager_bewart_typ_bez
    ELSE NULL
    END)) AS lager_bewart_typ_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN lager_bewart_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lager_bewart_typ_bez
    ELSE NULL
    END)) AS lager_bewart_typ_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN lager_bewart_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lager_bewart_typ_bez
    ELSE NULL
    END)) AS lager_bewart_typ_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN lager_bewart_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lager_bewart_typ_bez
    ELSE NULL
    END)) AS lager_bewart_typ_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN lager_bewart_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lager_bewart_typ_bez
    ELSE NULL
    END)) AS lager_bewart_typ_bez_bg
FROM kfl_production_dbp_view.v_lager_bewart_typ_spr_zu AS V01
WHERE hist_fg = 0
GROUP BY mandant_id,
 lager_bewart_typ_id;