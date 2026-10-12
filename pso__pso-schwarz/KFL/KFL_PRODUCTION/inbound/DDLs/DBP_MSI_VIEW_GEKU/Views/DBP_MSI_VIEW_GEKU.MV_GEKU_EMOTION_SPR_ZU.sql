CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_EMOTION_SPR_ZU
(
geku_emotion_id
,geku_emotion_bez
,geku_emotion_bez_cz
,geku_emotion_bez_pl
,geku_emotion_bez_sk
,geku_emotion_bez_hr
,geku_emotion_bez_ro
,geku_emotion_bez_bg
)
AS
-- 08.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.geku_emotion_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.geku_emotion_bez ELSE NULL END)  AS geku_emotion_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.geku_emotion_bez ELSE NULL END)  AS geku_emotion_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.geku_emotion_bez ELSE NULL END)  AS geku_emotion_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.geku_emotion_bez ELSE NULL END)  AS geku_emotion_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.geku_emotion_bez ELSE NULL END)  AS geku_emotion_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.geku_emotion_bez ELSE NULL END)  AS geku_emotion_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.geku_emotion_bez ELSE NULL END)  AS geku_emotion_bez_bg

   FROM dbp_view.v_geku_emotion_spr_zu v01

   GROUP BY v01.geku_emotion_id;