CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_ART_SPR_ZU_2(
	MANDANT_ID,
	ART_ID,
	KL_ART_ID,
	ART_BEZ,
	ART_BEZ_DE,
	ART_BEZ_CZ,
	ART_BEZ_SK,
	ART_BEZ_HR,
	ART_BEZ_PL,
	ART_BEZ_RO,
	ART_BEZ_BG
) AS SELECT
    v01.mandant_id
   ,v01.art_id
   ,v02.kl_art_id
   , COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.art_bez END),'N/A') AS art_bez  -- Standard == DE
   , COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.art_bez END),'N/A') AS art_bez_de                                        -- DE
   , COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.art_bez END), art_bez_de) AS art_bez_cz                                   -- CZ
   , COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.art_bez END), art_bez_de) AS art_bez_sk                                   -- SK
   , COALESCE(MAX(CASE WHEN v01.spr_id =  65  THEN v01.art_bez END), art_bez_de) AS art_bez_hr                                  -- HR
   , COALESCE(MAX(CASE WHEN v01.spr_id =  90  THEN v01.art_bez END), art_bez_de) AS art_bez_pl                                  -- PL
   , COALESCE(MAX(CASE WHEN v01.spr_id =  95  THEN v01.art_bez END), art_bez_de) AS art_bez_ro                                  -- RO
   , COALESCE(MAX(CASE WHEN v01.spr_id =  18  THEN v01.art_bez END), art_bez_de) AS art_bez_bg                                  -- BG

FROM dbp_view.v_art_spr_zu_2 v01

JOIN dbp_view.v_art_2 v02
    ON (v01.art_id = v02.art_id
    AND v01.mandant_id = v02.mandant_id)

GROUP BY 1,2,3;