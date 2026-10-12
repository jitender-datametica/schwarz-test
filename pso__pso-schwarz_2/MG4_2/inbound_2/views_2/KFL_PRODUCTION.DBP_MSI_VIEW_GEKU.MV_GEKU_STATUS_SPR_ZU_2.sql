create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_STATUS_SPR_ZU_2(
	GEKU_STATUS_ID,
	GEKU_STATUS_BEZ,
	GEKU_STATUS_BEZ_CZ,
	GEKU_STATUS_BEZ_PL,
	GEKU_STATUS_BEZ_SK,
	GEKU_STATUS_BEZ_HR,
	GEKU_STATUS_BEZ_RO,
	GEKU_STATUS_BEZ_BG
) as
-- 01.03.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.geku_status_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.geku_status_bez ELSE NULL END)  AS geku_status_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.geku_status_bez ELSE NULL END)  AS geku_status_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.geku_status_bez ELSE NULL END)  AS geku_status_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.geku_status_bez ELSE NULL END)  AS geku_status_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.geku_status_bez ELSE NULL END)  AS geku_status_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.geku_status_bez ELSE NULL END)  AS geku_status_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.geku_status_bez ELSE NULL END)  AS geku_status_bez_bg

   FROM dbp_view.v_geku_status_spr_zu_2 v01

   GROUP BY v01.geku_status_id;