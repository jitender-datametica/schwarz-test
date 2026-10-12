create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_MZK_GRUND_SPR_ZU_1(
	GEKU_MZK_GRUND_UID,
	GEKU_MZK_GRUND_BEZ,
	GEKU_MZK_GRUND_BEZ_CZ,
	GEKU_MZK_GRUND_BEZ_PL,
	GEKU_MZK_GRUND_BEZ_SK,
	GEKU_MZK_GRUND_BEZ_HR,
	GEKU_MZK_GRUND_BEZ_RO,
	GEKU_MZK_GRUND_BEZ_BG
) as
-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.geku_mzk_grund_uid
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.geku_mzk_grund_bez ELSE NULL END)  AS geku_mzk_grund_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.geku_mzk_grund_bez ELSE NULL END)  AS geku_mzk_grund_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.geku_mzk_grund_bez ELSE NULL END)  AS geku_mzk_grund_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.geku_mzk_grund_bez ELSE NULL END)  AS geku_mzk_grund_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.geku_mzk_grund_bez ELSE NULL END)  AS geku_mzk_grund_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.geku_mzk_grund_bez ELSE NULL END)  AS geku_mzk_grund_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.geku_mzk_grund_bez ELSE NULL END)  AS geku_mzk_grund_bez_bg

   FROM dbp_view.v_geku_mzk_grund_spr_zu_1 v01

   GROUP BY v01.geku_mzk_grund_uid;