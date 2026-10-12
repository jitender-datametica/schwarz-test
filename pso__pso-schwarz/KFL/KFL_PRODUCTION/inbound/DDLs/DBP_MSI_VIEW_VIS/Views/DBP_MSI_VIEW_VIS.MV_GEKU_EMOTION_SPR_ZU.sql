CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_EMOTION_SPR_ZU as
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   geku_emotion_id, MAX(CASE WHEN spr_id =   22 THEN geku_emotion_bez ELSE NULL END)    AS geku_emotion_bez        --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN geku_emotion_bez ELSE NULL END)    AS geku_emotion_bez_de --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN geku_emotion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN geku_emotion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_emotion_bez ELSE NULL END)
   END  AS geku_emotion_bez_cz                   --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN geku_emotion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN geku_emotion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_emotion_bez ELSE NULL END)
   END  AS geku_emotion_bez_pl                   --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN geku_emotion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN geku_emotion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_emotion_bez ELSE NULL END)
   END  AS geku_emotion_bez_sk                   --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN geku_emotion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN geku_emotion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_emotion_bez ELSE NULL END)
   END  AS geku_emotion_bez_hr                   -- kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN geku_emotion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN geku_emotion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_emotion_bez ELSE NULL END)
   END  AS geku_emotion_bez_ro                   --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN geku_emotion_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN geku_emotion_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN geku_emotion_bez ELSE NULL END)
   END  AS geku_emotion_bez_bg                   --bulgarisch

   FROM dbp_view.v_geku_emotion_spr_zu v01
   GROUP BY
   geku_emotion_id;