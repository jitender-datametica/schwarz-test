create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_MASSNAHME_SPR_ZU_2(
	GEKU_MASSNAHME_UID,
	GEKU_MASSNAHME_BEZ,
	GEKU_MASSNAHME_BEZ_CZ,
	GEKU_MASSNAHME_BEZ_PL,
	GEKU_MASSNAHME_BEZ_SK,
	GEKU_MASSNAHME_BEZ_HR,
	GEKU_MASSNAHME_BEZ_RO,
	GEKU_MASSNAHME_BEZ_BG
) as
-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.geku_massnahme_uid
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.geku_massnahme_bez ELSE NULL END)  AS geku_massnahme_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.geku_massnahme_bez ELSE NULL END)  AS geku_massnahme_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.geku_massnahme_bez ELSE NULL END)  AS geku_massnahme_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.geku_massnahme_bez ELSE NULL END)  AS geku_massnahme_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.geku_massnahme_bez ELSE NULL END)  AS geku_massnahme_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.geku_massnahme_bez ELSE NULL END)  AS geku_massnahme_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.geku_massnahme_bez ELSE NULL END)  AS geku_massnahme_bez_bg

   FROM dbp_view.v_geku_massnahme_spr_zu_2 v01

   GROUP BY v01.geku_massnahme_uid;