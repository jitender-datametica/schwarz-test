CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_STANDARDLOESUNG_FG_SPR_ZU_2
AS
-- 04.02.2020 lsvi: SPEC0064978 Sprachview CRM Standardloesung Flag

   SELECT

    v01.flag AS standardloesung_fg
    , MAX(CASE WHEN v01.spr_id =   22 THEN v01.flag_bez ELSE NULL END)  AS standardloesung_fg_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.flag_bez ELSE NULL END)  AS standardloesung_fg_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.flag_bez ELSE NULL END)  AS standardloesung_fg_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.flag_bez ELSE NULL END)  AS standardloesung_fg_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.flag_bez ELSE NULL END)  AS standardloesung_fg_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.flag_bez ELSE NULL END)  AS standardloesung_fg_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.flag_bez ELSE NULL END)  AS standardloesung_fg_bez_bg

   FROM dbp_view.v_flag_spr_zu_2 v01

   WHERE flag_typ_id = 1 --Ja/Nein

   GROUP BY v01.flag;