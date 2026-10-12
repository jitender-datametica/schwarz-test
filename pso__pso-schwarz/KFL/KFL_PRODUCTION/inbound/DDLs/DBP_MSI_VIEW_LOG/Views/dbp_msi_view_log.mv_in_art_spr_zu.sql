CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_ART_SPR_ZU(
	MANDANT_ID,
	IN_ART_ID,
	ART_BEZ,
	ART_BEZ_DE,
	ART_BEZ_CZ,
	ART_BEZ_SK,
	ART_BEZ_HR,
	ART_BEZ_PL,
	ART_BEZ_RO,
	ART_BEZ_BG
) AS
--AP0133256_SPEC0166769, dknop, initial

SELECT
 v01.mandant_id
,v01.in_art_id
,MAX(CASE WHEN v01.spr_id =  22 THEN v01.art_bez END) AS art_bez                 -- standard == DE
,MAX(CASE WHEN v01.spr_id =  22 THEN v01.art_bez END) AS art_bez_de                       -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.art_bez END), art_bez_de) AS art_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.art_bez END), art_bez_de) AS art_bez_sk   -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.art_bez END), art_bez_de) AS art_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.art_bez END), art_bez_de) AS art_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.art_bez END), art_bez_de) AS art_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.art_bez END), art_bez_de) AS art_bez_bg    -- BG

FROM dbp_view.v_in_art_spr_zu v01
GROUP BY v01.mandant_id
        ,v01.in_art_id;