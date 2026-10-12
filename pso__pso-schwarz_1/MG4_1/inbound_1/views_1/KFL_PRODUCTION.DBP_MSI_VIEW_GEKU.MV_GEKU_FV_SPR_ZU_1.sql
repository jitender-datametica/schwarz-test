create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_FV_SPR_ZU_1(
	FV_FG,
	FV_BEZ,
	FV_BEZ_CZ,
	FV_BEZ_PL,
	FV_BEZ_SK,
	FV_BEZ_HR,
	FV_BEZ_RO,
	FV_BEZ_BG
) as
-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.fv_fg
   , MAX(CASE WHEN v01.spr_id =  22 THEN v01.fv_bez ELSE NULL END) AS fv_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.fv_bez ELSE NULL END) AS fv_bez_cz
   , MAX(CASE WHEN v01.spr_id =  90 THEN v01.fv_bez ELSE NULL END) AS fv_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.fv_bez ELSE NULL END) AS fv_bez_sk
   , MAX(CASE WHEN v01.spr_id =  65 THEN v01.fv_bez ELSE NULL END) AS fv_bez_hr
   , MAX(CASE WHEN v01.spr_id =  95 THEN v01.fv_bez ELSE NULL END) AS fv_bez_ro
   , MAX(CASE WHEN v01.spr_id =  18 THEN v01.fv_bez ELSE NULL END) AS fv_bez_bg

   FROM dbp_view.v_geku_fv_spr_zu_1 v01

   GROUP BY v01.fv_fg;