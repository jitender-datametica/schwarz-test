create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_KUNDENFAKTOR_SPR_ZU(
	KUNDENFAKTOR_ID,
	KF_KOMMENTAR,
	KF_KOMMENTAR_CZ,
	KF_KOMMENTAR_PL,
	KF_KOMMENTAR_SK,
	KF_KOMMENTAR_HR,
	KF_KOMMENTAR_RO,
	KF_KOMMENTAR_BG,
	KF_BEZ,
	KF_BEZ_CZ,
	KF_BEZ_PL,
	KF_BEZ_SK,
	KF_BEZ_HR,
	KF_BEZ_RO,
	KF_BEZ_BG
) as
-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   kundenfaktor_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.kf_kommentar ELSE NULL END)  AS kf_kommentar   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.kf_kommentar ELSE NULL END)  AS kf_kommentar_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.kf_kommentar ELSE NULL END)  AS kf_kommentar_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.kf_kommentar ELSE NULL END)  AS kf_kommentar_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.kf_kommentar ELSE NULL END)  AS kf_kommentar_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.kf_kommentar ELSE NULL END)  AS kf_kommentar_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.kf_kommentar ELSE NULL END)  AS kf_kommentar_bg
   
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.kf_bez ELSE NULL END)  AS kf_bez --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.kf_bez ELSE NULL END)  AS kf_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.kf_bez ELSE NULL END)  AS kf_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.kf_bez ELSE NULL END)  AS kf_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.kf_bez ELSE NULL END)  AS kf_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.kf_bez ELSE NULL END)  AS kf_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.kf_bez ELSE NULL END)  AS kf_bez_bg

   FROM dbp_view.v_geku_kundenfaktor_spr_zu v01

   GROUP BY v01.kundenfaktor_id;