-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert
 -- standard=deutsch

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_geku_notenvergabe_spr_zu_2 (geku_notenvergabe_durch_id,
geku_notenvergabe_durch_bez, geku_notenvergabe_durch_bez_cz, geku_notenvergabe_durch_bez_pl,
geku_notenvergabe_durch_bez_sk, geku_notenvergabe_durch_bez_hr, geku_notenvergabe_durch_bez_ro,
geku_notenvergabe_durch_bez_bg) AS SELECT geku_notenvergabe_durch_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN geku_notenvergabe_durch_bez
   ELSE NULL
   END) AS geku_notenvergabe_durch_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN geku_notenvergabe_durch_bez
   ELSE NULL
   END) AS geku_notenvergabe_durch_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN geku_notenvergabe_durch_bez
   ELSE NULL
   END) AS geku_notenvergabe_durch_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN geku_notenvergabe_durch_bez
   ELSE NULL
   END) AS geku_notenvergabe_durch_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN geku_notenvergabe_durch_bez
   ELSE NULL
   END) AS geku_notenvergabe_durch_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN geku_notenvergabe_durch_bez
   ELSE NULL
   END) AS geku_notenvergabe_durch_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN geku_notenvergabe_durch_bez
   ELSE NULL
   END) AS geku_notenvergabe_durch_bez_bg
FROM kfl_production_dbp_view.v_geku_notenvergabe_spr_zu_2 AS v01
GROUP BY geku_notenvergabe_durch_id;