CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_LAGERPROZESSART_SPR_ZU_PROMPT_2(
	LAGERPROZESSART_ID,
	LAGERPROZESSART_BEZ,
	LAGERPROZESSART_BEZ_DE,
	LAGERPROZESSART_BEZ_CZ,
	LAGERPROZESSART_BEZ_SK,
	LAGERPROZESSART_BEZ_HR,
	LAGERPROZESSART_BEZ_PL,
	LAGERPROZESSART_BEZ_RO,
	LAGERPROZESSART_BEZ_BG
) AS
--2023-05-08, AP0161535, dknop, initial
SELECT

 v01.lagerprozessart_id
,MAX(CASE WHEN v01.spr_id =  22 THEN v01.lagerprozessart_bez END) AS lagerprozessart_bez                 -- standard == DE
,MAX(CASE WHEN v01.spr_id =  22 THEN v01.lagerprozessart_bez END) AS lagerprozessart_bez_de                          -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.lagerprozessart_bez END), lagerprozessart_bez_de) AS lagerprozessart_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.lagerprozessart_bez END), lagerprozessart_bez_de) AS lagerprozessart_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.lagerprozessart_bez END), lagerprozessart_bez_de) AS lagerprozessart_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.lagerprozessart_bez END), lagerprozessart_bez_de) AS lagerprozessart_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.lagerprozessart_bez END), lagerprozessart_bez_de) AS lagerprozessart_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.lagerprozessart_bez END), lagerprozessart_bez_de) AS lagerprozessart_bez_bg    -- BG
FROM dbp_view.v_lagerprozessart_spr_zu_2 v01
GROUP BY 
        v01.lagerprozessart_id;