-- standard=deutsch
 -- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_geku_mzk_thema_spr_zu_1 (geku_mzk_thema_uid, geku_mzk_thema_bez,
geku_mzk_thema_bez_cz, geku_mzk_thema_bez_pl, geku_mzk_thema_bez_sk, geku_mzk_thema_bez_hr, geku_mzk_thema_bez_ro,
geku_mzk_thema_bez_bg) AS SELECT geku_mzk_thema_uid,
 MAX(CASE
   WHEN spr_id = 22
   THEN geku_mzk_thema_bez
   ELSE NULL
   END) AS geku_mzk_thema_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN geku_mzk_thema_bez
   ELSE NULL
   END) AS geku_mzk_thema_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN geku_mzk_thema_bez
   ELSE NULL
   END) AS geku_mzk_thema_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN geku_mzk_thema_bez
   ELSE NULL
   END) AS geku_mzk_thema_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN geku_mzk_thema_bez
   ELSE NULL
   END) AS geku_mzk_thema_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN geku_mzk_thema_bez
   ELSE NULL
   END) AS geku_mzk_thema_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN geku_mzk_thema_bez
   ELSE NULL
   END) AS geku_mzk_thema_bez_bg
FROM kfl_production_dbp_view.v_geku_mzk_thema_spr_zu_1 AS v01
GROUP BY geku_mzk_thema_uid;