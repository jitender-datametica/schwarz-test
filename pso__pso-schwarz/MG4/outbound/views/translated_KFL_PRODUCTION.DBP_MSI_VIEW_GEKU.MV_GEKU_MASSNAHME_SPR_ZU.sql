-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_massnahme_spr_zu (geku_massnahme_uid, geku_massnahme_bez
, geku_massnahme_bez_cz, geku_massnahme_bez_pl, geku_massnahme_bez_sk, geku_massnahme_bez_hr, geku_massnahme_bez_ro,
geku_massnahme_bez_bg) AS -- standard=deutsch
 SELECT geku_massnahme_uid,
 MAX(CASE
   WHEN spr_id = 22
   THEN geku_massnahme_bez
   ELSE NULL
   END) AS geku_massnahme_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN geku_massnahme_bez
   ELSE NULL
   END) AS geku_massnahme_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN geku_massnahme_bez
   ELSE NULL
   END) AS geku_massnahme_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN geku_massnahme_bez
   ELSE NULL
   END) AS geku_massnahme_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN geku_massnahme_bez
   ELSE NULL
   END) AS geku_massnahme_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN geku_massnahme_bez
   ELSE NULL
   END) AS geku_massnahme_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN geku_massnahme_bez
   ELSE NULL
   END) AS geku_massnahme_bez_bg
FROM kfl_production_dbp_view.v_geku_massnahme_spr_zu AS v01
GROUP BY geku_massnahme_uid;