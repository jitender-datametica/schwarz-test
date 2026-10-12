CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_ART_SPR_ZU_2
(
	ART_ID,
	MANDANT_ID,
	ART_BEZ,
	ART_BEZ_CZ,
	ART_BEZ_PL,
	ART_BEZ_SK,
	ART_BEZ_HR,
	ART_BEZ_RO,
	ART_BEZ_BG
) AS
-- 10.05.2022 twie: SPEC0145413 Sprachview Artikel_2
-- 26.01.2023 twie: SPEC0181015 wenn art_id = 0 dann art_bez leer

   SELECT

   v01.art_id
   ,mandant_id
   ,MAX(CASE WHEN v01.spr_id =   22 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id = 124  AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_cz
   ,MAX(CASE WHEN v01.spr_id =   90 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108  AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_sk
   ,MAX(CASE WHEN v01.spr_id =   65 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_hr
   ,MAX(CASE WHEN v01.spr_id =   95 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_ro
   ,MAX(CASE WHEN v01.spr_id =   18 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_bg

   FROM dbp_view.v_art_spr_zu_2 v01

   GROUP BY v01.art_id, mandant_id;