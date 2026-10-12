-- standard=deutsch
 -- 08.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_geku_artikel_spr_zu (geku_artikel_uid, geku_artikel_bez, geku_artikel_bez_cz
, geku_artikel_bez_pl, geku_artikel_bez_sk, geku_artikel_bez_hr, geku_artikel_bez_ro, geku_artikel_bez_bg) AS SELECT
 geku_artikel_uid,
 MAX(CASE
   WHEN spr_id = 22
   THEN geku_artikel_bez
   ELSE NULL
   END) AS geku_artikel_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN geku_artikel_bez
   ELSE NULL
   END) AS geku_artikel_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN geku_artikel_bez
   ELSE NULL
   END) AS geku_artikel_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN geku_artikel_bez
   ELSE NULL
   END) AS geku_artikel_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN geku_artikel_bez
   ELSE NULL
   END) AS geku_artikel_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN geku_artikel_bez
   ELSE NULL
   END) AS geku_artikel_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN geku_artikel_bez
   ELSE NULL
   END) AS geku_artikel_bez_bg
FROM kfl_production_dbp_view.v_geku_artikel_spr_zu AS v01
GROUP BY geku_artikel_uid;