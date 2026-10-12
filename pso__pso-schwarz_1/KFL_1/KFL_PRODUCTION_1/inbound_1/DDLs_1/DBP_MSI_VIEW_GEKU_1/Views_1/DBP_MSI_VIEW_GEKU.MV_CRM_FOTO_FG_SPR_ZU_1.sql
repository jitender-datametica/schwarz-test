CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_FOTO_FG_SPR_ZU_1
AS
-- 22.07.2019 twie: SPEC0059158 Sprachview CRM Foto Flag

   SELECT

   v01.flag AS foto_fg
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.flag_bez ELSE NULL END)  AS foto_fg_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.flag_bez ELSE NULL END)  AS foto_fg_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.flag_bez ELSE NULL END)  AS foto_fg_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.flag_bez ELSE NULL END)  AS foto_fg_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.flag_bez ELSE NULL END)  AS foto_fg_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.flag_bez ELSE NULL END)  AS foto_fg_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.flag_bez ELSE NULL END)  AS foto_fg_bez_bg

   FROM dbp_view.v_flag_spr_zu_1 v01

   WHERE flag_typ_id = 1 --Ja/Nein

   GROUP BY v01.flag;