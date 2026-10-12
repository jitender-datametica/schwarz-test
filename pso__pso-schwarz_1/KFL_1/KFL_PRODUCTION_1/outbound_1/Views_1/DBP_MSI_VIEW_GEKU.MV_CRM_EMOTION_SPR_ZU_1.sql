CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_emotion_spr_zu_1 AS SELECT crm_emotion_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN emotion_bez
   ELSE NULL
   END) AS emotion_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN emotion_bez
   ELSE NULL
   END) AS emotion_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN emotion_bez
   ELSE NULL
   END) AS emotion_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN emotion_bez
   ELSE NULL
   END) AS emotion_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN emotion_bez
   ELSE NULL
   END) AS emotion_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN emotion_bez
   ELSE NULL
   END) AS emotion_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN emotion_bez
   ELSE NULL
   END) AS emotion_bez_bg
FROM kfl_production_dbp_view.v_crm_emotion_spr_zu_1 AS V01
GROUP BY crm_emotion_id;