create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_NOTENVERGABE_SPR_ZU(
	GEKU_NOTENVERGABE_DURCH_ID,
	GEKU_NOTENVERGABE_DURCH_BEZ,
	GEKU_NOTENVERGABE_DURCH_BEZ_CZ,
	GEKU_NOTENVERGABE_DURCH_BEZ_PL,
	GEKU_NOTENVERGABE_DURCH_BEZ_SK,
	GEKU_NOTENVERGABE_DURCH_BEZ_HR,
	GEKU_NOTENVERGABE_DURCH_BEZ_RO,
	GEKU_NOTENVERGABE_DURCH_BEZ_BG
) as
-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.geku_notenvergabe_durch_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.geku_notenvergabe_durch_bez ELSE NULL END)  AS geku_notenvergabe_durch_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.geku_notenvergabe_durch_bez ELSE NULL END)  AS geku_notenvergabe_durch_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.geku_notenvergabe_durch_bez ELSE NULL END)  AS geku_notenvergabe_durch_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.geku_notenvergabe_durch_bez ELSE NULL END)  AS geku_notenvergabe_durch_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.geku_notenvergabe_durch_bez ELSE NULL END)  AS geku_notenvergabe_durch_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.geku_notenvergabe_durch_bez ELSE NULL END)  AS geku_notenvergabe_durch_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.geku_notenvergabe_durch_bez ELSE NULL END)  AS geku_notenvergabe_durch_bez_bg

   FROM dbp_view.v_geku_notenvergabe_spr_zu v01

   GROUP BY v01.geku_notenvergabe_durch_id;