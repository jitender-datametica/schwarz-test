CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_SPERRGRUND_SPR_ZU_2(
	SPERRGRUND_ID,
	MANDANT_ID,
	SPERRGRUND_BEZ,
	SPERRGRUND_BEZ_DE,
	SPERRGRUND_BEZ_CZ,
	SPERRGRUND_BEZ_SK,
	SPERRGRUND_BEZ_HR,
	SPERRGRUND_BEZ_PL,
	SPERRGRUND_BEZ_RO,
	SPERRGRUND_BEZ_BG
) AS
--2022.03.28, AP0124145_SPEC0149178, dknop, initial

SELECT 
 v01.sperrgrund_id
,v01.mandant_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.sperrgrund_bez END) AS sperrgrund_bez                        -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.sperrgrund_bez END) AS sperrgrund_bez_de                                  -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.sperrgrund_bez END),sperrgrund_bez_de) AS sperrgrund_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.sperrgrund_bez END),sperrgrund_bez_de) AS sperrgrund_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.sperrgrund_bez END),sperrgrund_bez_de) AS sperrgrund_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.sperrgrund_bez END),sperrgrund_bez_de) AS sperrgrund_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.sperrgrund_bez END),sperrgrund_bez_de) AS sperrgrund_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.sperrgrund_bez END),sperrgrund_bez_de) AS sperrgrund_bez_bg    -- BG
FROM  dbp_view.v_sperrgrund_spr_zu_2 v01
GROUP BY v01.sperrgrund_id,
v01.mandant_id;