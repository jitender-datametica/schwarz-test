CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_crm_emotion_spr_zu_2
-- -- 04.06.2020 lsvi0303: Initial AP0048480, SPEC0075325
AS
SELECT

v01.crm_emotion_id,
MAX(CASE WHEN v01.spr_id =   22 THEN v01.emotion_bez ELSE NULL END)  AS emotion_bez   --standard=deutsch
,
MAX(CASE WHEN v01.spr_id = 124 THEN v01.emotion_bez ELSE NULL END)  AS emotion_bez_cz,
MAX(CASE WHEN v01.spr_id =   90 THEN v01.emotion_bez ELSE NULL END)  AS emotion_bez_pl,
MAX(CASE WHEN v01.spr_id = 108 THEN v01.emotion_bez ELSE NULL END)  AS emotion_bez_sk,
MAX(CASE WHEN v01.spr_id =   65 THEN v01.emotion_bez ELSE NULL END)  AS emotion_bez_hr,
MAX(CASE WHEN v01.spr_id =   95 THEN v01.emotion_bez ELSE NULL END)  AS emotion_bez_ro,
MAX(CASE WHEN v01.spr_id =   18 THEN v01.emotion_bez ELSE NULL END)  AS emotion_bez_bg
FROM dbp_view.v_crm_emotion_spr_zu_2 v01

GROUP BY v01.crm_emotion_id;