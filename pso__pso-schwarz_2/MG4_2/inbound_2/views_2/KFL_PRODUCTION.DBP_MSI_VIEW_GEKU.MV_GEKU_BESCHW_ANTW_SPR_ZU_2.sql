create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_BESCHW_ANTW_SPR_ZU_2(
	BESCHWERDE_ANTWORT_ID,
	BESCHWERDE_ANTW_BEZ,
	BESCHWERDE_ANTW_BEZ_CZ,
	BESCHWERDE_ANTW_BEZ_PL,
	BESCHWERDE_ANTW_BEZ_SK,
	BESCHWERDE_ANTW_BEZ_HR,
	BESCHWERDE_ANTW_BEZ_RO,
	BESCHWERDE_ANTW_BEZ_BG
) as
-- 08.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT
   v01.beschwerde_antwort_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.beschwerde_antw_bez ELSE NULL END)  AS beschwerde_antw_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.beschwerde_antw_bez ELSE NULL END)  AS beschwerde_antw_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.beschwerde_antw_bez ELSE NULL END)  AS beschwerde_antw_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.beschwerde_antw_bez ELSE NULL END)  AS beschwerde_antw_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.beschwerde_antw_bez ELSE NULL END)  AS beschwerde_antw_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.beschwerde_antw_bez ELSE NULL END)  AS beschwerde_antw_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.beschwerde_antw_bez ELSE NULL END)  AS beschwerde_antw_bez_bg

   FROM dbp_view.v_geku_beschw_antw_spr_zu_2 v01

   GROUP BY v01.beschwerde_antwort_id;