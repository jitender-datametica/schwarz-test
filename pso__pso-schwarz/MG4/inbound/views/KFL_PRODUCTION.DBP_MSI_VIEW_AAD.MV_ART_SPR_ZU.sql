create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_ART_SPR_ZU(
	ART_ID,
	MANDANT_ID,
	ART_BEZ,
	ART_BEZ_CZ,
	ART_BEZ_PL,
	ART_BEZ_SK,
	ART_BEZ_HR,
	ART_BEZ_RO,
	ART_BEZ_BG
) as
--15.06.2023 snik: SPEC0200542 Artikel Sprachview
   SELECT
   v01.art_id
   ,v01.mandant_id
   ,MAX(CASE WHEN v01.spr_id =   22 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id = 124  AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_cz
   ,MAX(CASE WHEN v01.spr_id =   90 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108  AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_sk
   ,MAX(CASE WHEN v01.spr_id =   65 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_hr
   ,MAX(CASE WHEN v01.spr_id =   95 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_ro
   ,MAX(CASE WHEN v01.spr_id =   18 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_bg
FROM dbp_view.v_art_spr_zu v01
GROUP BY v01.art_id, v01.mandant_id;