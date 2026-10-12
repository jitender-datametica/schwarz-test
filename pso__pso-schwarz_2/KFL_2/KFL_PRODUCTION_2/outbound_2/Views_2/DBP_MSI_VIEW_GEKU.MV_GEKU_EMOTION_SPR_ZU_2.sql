CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_emotion_spr_zu_2 (geku_emotion_id, geku_emotion_bez,
geku_emotion_bez_cz, geku_emotion_bez_pl, geku_emotion_bez_sk, geku_emotion_bez_hr, geku_emotion_bez_ro,
geku_emotion_bez_bg) AS SELECT geku_emotion_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN geku_emotion_bez
   ELSE NULL
   END) AS geku_emotion_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN geku_emotion_bez
   ELSE NULL
   END) AS geku_emotion_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN geku_emotion_bez
   ELSE NULL
   END) AS geku_emotion_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN geku_emotion_bez
   ELSE NULL
   END) AS geku_emotion_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN geku_emotion_bez
   ELSE NULL
   END) AS geku_emotion_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN geku_emotion_bez
   ELSE NULL
   END) AS geku_emotion_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN geku_emotion_bez
   ELSE NULL
   END) AS geku_emotion_bez_bg
FROM kfl_production_dbp_view.v_geku_emotion_spr_zu_2 AS V01
GROUP BY geku_emotion_id;