CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_abschriftart_thema_int_spr_zu_2 AS SELECT
 abschriftart_thema_int_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN abschriftart_thema_int_bez
   ELSE NULL
   END) AS abschriftart_thema_int_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN abschriftart_thema_int_bez
   ELSE NULL
   END) AS abschriftart_thema_int_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN abschriftart_thema_int_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_thema_int_bez
    ELSE NULL
    END)) AS abschriftart_thema_int_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN abschriftart_thema_int_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_thema_int_bez
    ELSE NULL
    END)) AS abschriftart_thema_int_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN abschriftart_thema_int_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_thema_int_bez
    ELSE NULL
    END)) AS abschriftart_thema_int_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN abschriftart_thema_int_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_thema_int_bez
    ELSE NULL
    END)) AS abschriftart_thema_int_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN abschriftart_thema_int_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_thema_int_bez
    ELSE NULL
    END)) AS abschriftart_thema_int_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN abschriftart_thema_int_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_thema_int_bez
    ELSE NULL
    END)) AS abschriftart_thema_int_bez_bg
FROM kfl_production_dbp_view.v_abschriftart_thema_int_spr_zu_2 AS ATIS
GROUP BY abschriftart_thema_int_id;