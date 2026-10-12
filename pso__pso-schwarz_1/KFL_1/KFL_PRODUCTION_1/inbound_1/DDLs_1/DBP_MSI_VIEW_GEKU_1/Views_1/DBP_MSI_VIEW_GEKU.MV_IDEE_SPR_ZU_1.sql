CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_IDEE_SPR_ZU_1
(
idee_fg
,idee_bez
,idee_bez_cz
,idee_bez_pl
,idee_bez_sk
,idee_bez_hr
,idee_bez_ro
,idee_bez_bg
)
AS
-- 23.03.2015 twie: Sprachview Idee aus universeller Flagtabelle ja/nein
-- 01.03.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.flag AS idee_fg
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.flag_bez ELSE NULL END)  AS idee_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.flag_bez ELSE NULL END)  AS idee_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.flag_bez ELSE NULL END)  AS idee_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.flag_bez ELSE NULL END)  AS idee_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.flag_bez ELSE NULL END)  AS idee_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.flag_bez ELSE NULL END)  AS idee_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.flag_bez ELSE NULL END)  AS idee_bez_bg

   FROM dbp_view.v_flag_spr_zu_1 v01

   WHERE  flag_typ_id = 1 -- entspricht ja/nein Flag

   GROUP BY v01.flag;