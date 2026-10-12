CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_PRUEFKATALOG_CODE_SPR_ZU_2(
	KATALOGART_ID,
	CODEGRUPPE_ID,
	PRUEFCODE_ID,
	VERSION_ID,
	QTXT_CODE,
	QTXT_CODE_DE,
	QTXT_CODE_CZ,
	QTXT_CODE_SK,
	QTXT_CODE_HR,
	QTXT_CODE_PL,
	QTXT_CODE_RO,
	QTXT_CODE_BG
) AS
--2022-08-29, AP0133256,SPEC0166769,dknop, initial

SELECT 
 v01.katalogart_id
,CASE WHEN v01.codegruppe_id = 'KLOAUTM' THEN SUBSTR(v01.codegruppe_id,1,3) ELSE v01.codegruppe_id END AS codegruppe1_id
,pruefcode_id
,version_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.qtxt_code END) AS qtxt_code                        -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.qtxt_code END) AS qtxt_code_de                                  -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.qtxt_code END), qtxt_code_de) AS qtxt_code_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.qtxt_code END), qtxt_code_de) AS qtxt_code_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.qtxt_code END), qtxt_code_de) AS qtxt_code_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.qtxt_code END), qtxt_code_de) AS qtxt_code_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.qtxt_code END), qtxt_code_de) AS qtxt_code_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.qtxt_code END), qtxt_code_de) AS qtxt_code_bg    -- BG

FROM dbp_view.v_in_pruefkatalog_code_spr_zu_2 v01

GROUP BY 
 v01.katalogart_id
,codegruppe1_id 
,v01.pruefcode_id
,v01.version_id

UNION

SELECT
 
 '0' AS katalogart_id
,'-1' AS codegruppe_id
,'-1' AS pruefcode_id
,'-1' AS version_id
,'' AS qtxt_code
,'' AS qtxt_code_de   
,'' AS qtxt_code_cz
,'' AS qtxt_code_sk 
,'' AS qtxt_code_hr
,'' AS qtxt_code_pl
,'' AS qtxt_code_ro
,'' AS qtxt_code_bg

UNION
SELECT
 
 '0' AS katalogart_id
,'-1' AS codegruppe_id
,'0' AS pruefcode_id
,'-1' AS version_id
,'' AS qtxt_code
,'' AS qtxt_code_de   
,'' AS qtxt_code_cz
,'' AS qtxt_code_sk 
,'' AS qtxt_code_hr
,'' AS qtxt_code_pl
,'' AS qtxt_code_ro
,'' AS qtxt_code_bg

UNION
               
SELECT
 '0' AS katalogart_id
,'-1' AS codegruppe_id
,pruefcode_id
,'-1' AS version_id
,'' AS qtxt_code
,'' AS qtxt_code_de   
,'' AS qtxt_code_cz
,'' AS qtxt_code_sk 
,'' AS qtxt_code_hr
,'' AS qtxt_code_pl
,'' AS qtxt_code_ro
,'' AS qtxt_code_bg
FROM dbp_view.v_in_pruefkatalog_code_spr_zu_2 v01
GROUP BY 
 v01.katalogart_id
,v01.codegruppe_id 
,v01.pruefcode_id
,v01.version_id

;