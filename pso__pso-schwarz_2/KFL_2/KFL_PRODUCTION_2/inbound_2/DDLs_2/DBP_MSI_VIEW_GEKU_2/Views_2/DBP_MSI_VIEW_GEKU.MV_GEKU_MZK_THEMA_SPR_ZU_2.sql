CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_MZK_THEMA_SPR_ZU_2
(
geku_mzk_thema_uid
,geku_mzk_thema_bez
,geku_mzk_thema_bez_cz
,geku_mzk_thema_bez_pl
,geku_mzk_thema_bez_sk
,geku_mzk_thema_bez_hr
,geku_mzk_thema_bez_ro
,geku_mzk_thema_bez_bg
)
AS
-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.geku_mzk_thema_uid
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.geku_mzk_thema_bez ELSE NULL END)  AS geku_mzk_thema_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.geku_mzk_thema_bez ELSE NULL END)  AS geku_mzk_thema_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.geku_mzk_thema_bez ELSE NULL END)  AS geku_mzk_thema_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.geku_mzk_thema_bez ELSE NULL END)  AS geku_mzk_thema_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.geku_mzk_thema_bez ELSE NULL END)  AS geku_mzk_thema_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.geku_mzk_thema_bez ELSE NULL END)  AS geku_mzk_thema_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.geku_mzk_thema_bez ELSE NULL END)  AS geku_mzk_thema_bez_bg

   FROM dbp_view.v_geku_mzk_thema_spr_zu_2 v01

   GROUP BY v01.geku_mzk_thema_uid;