create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_BERECHTIGT_SPR_ZU(
	BERECHTIGT_FG,
	BERECHTIGT_BEZ,
	BERECHTIGT_BEZ_CZ,
	BERECHTIGT_BEZ_PL,
	BERECHTIGT_BEZ_SK,
	BERECHTIGT_BEZ_HR,
	BERECHTIGT_BEZ_RO,
	BERECHTIGT_BEZ_BG
) as
-- 08.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.berechtigt_fg
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.berechtigt_bez ELSE NULL END)  AS berechtigt_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.berechtigt_bez ELSE NULL END)  AS berechtigt_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.berechtigt_bez ELSE NULL END)  AS berechtigt_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.berechtigt_bez ELSE NULL END)  AS berechtigt_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.berechtigt_bez ELSE NULL END)  AS berechtigt_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.berechtigt_bez ELSE NULL END)  AS berechtigt_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.berechtigt_bez ELSE NULL END)  AS berechtigt_bez_bg

   FROM dbp_view.v_geku_berechtigt_spr_zu v01

   GROUP BY v01.berechtigt_fg;