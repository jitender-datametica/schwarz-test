--Werbemittel Art Spr Zu


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_werbemittel_art_spr_zu (werbemittel_art_id,
werbemittel_art_bez, werbemittel_art_bez_de, werbemittel_art_bez_cz, werbemittel_art_bez_sk, werbemittel_art_bez_hr,
werbemittel_art_bez_pl, werbemittel_art_bez_ro, werbemittel_art_bez_bg) AS SELECT werbemittel_art_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN werbemittel_art_bez
   ELSE NULL
   END) AS werbemittel_art_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN werbemittel_art_bez
   ELSE NULL
   END) AS werbemittel_art_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN werbemittel_art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN werbemittel_art_bez
    ELSE NULL
    END)) AS werbemittel_art_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN werbemittel_art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN werbemittel_art_bez
    ELSE NULL
    END)) AS werbemittel_art_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN werbemittel_art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN werbemittel_art_bez
    ELSE NULL
    END)) AS werbemittel_art_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN werbemittel_art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN werbemittel_art_bez
    ELSE NULL
    END)) AS werbemittel_art_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN werbemittel_art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN werbemittel_art_bez
    ELSE NULL
    END)) AS werbemittel_art_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN werbemittel_art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN werbemittel_art_bez
    ELSE NULL
    END)) AS werbemittel_art_bez_bg
FROM kfl_production_dbp_view.v_werbemittel_art_spr_zu AS V01
GROUP BY werbemittel_art_id;