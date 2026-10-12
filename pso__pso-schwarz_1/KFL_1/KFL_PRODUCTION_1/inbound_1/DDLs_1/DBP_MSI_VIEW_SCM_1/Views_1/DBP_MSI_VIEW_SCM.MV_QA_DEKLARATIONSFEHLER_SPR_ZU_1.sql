CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_QA_DEKLARATIONSFEHLER_SPR_ZU_1(
	MANDANT_ID,
	QA_DEKLARATIONSFEHLER_ID,
	QA_DEKLARATIONSFEHLER_BEZ,
	QA_DEKLARATIONSFEHLER_BEZ_DE,
	QA_DEKLARATIONSFEHLER_BEZ_CZ,
	QA_DEKLARATIONSFEHLER_BEZ_SK,
	QA_DEKLARATIONSFEHLER_BEZ_HR,
	QA_DEKLARATIONSFEHLER_BEZ_PL,
	QA_DEKLARATIONSFEHLER_BEZ_RO,
	QA_DEKLARATIONSFEHLER_BEZ_B
) AS
--2025-03-06, AP0205147, dknop, initial
SELECT
 v01.mandant_id
,v01.qa_deklarationsfehler_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.qa_deklarationsfehler_bez END) AS qa_deklarationsfehler_bez                        -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.qa_deklarationsfehler_bez END) AS qa_deklarationsfehler_bez_de                                 -- DE
,MAX(CASE WHEN v01.spr_id = 124 THEN v01.qa_deklarationsfehler_bez END) AS qa_deklarationsfehler_bez_cz    -- CZ
,MAX(CASE WHEN v01.spr_id = 108 THEN v01.qa_deklarationsfehler_bez END) AS qa_deklarationsfehler_bez_sk    -- SK
,MAX(CASE WHEN v01.spr_id =  65 THEN v01.qa_deklarationsfehler_bez END) AS qa_deklarationsfehler_bez_hr    -- HR
,MAX(CASE WHEN v01.spr_id =  90 THEN v01.qa_deklarationsfehler_bez END) AS qa_deklarationsfehler_bez_pl    -- PL
,MAX(CASE WHEN v01.spr_id =  95 THEN v01.qa_deklarationsfehler_bez END) AS qa_deklarationsfehler_bez_ro    -- RO
,MAX(CASE WHEN v01.spr_id =  18 THEN v01.qa_deklarationsfehler_bez END) AS qa_deklarationsfehler_bez_b
FROM dbp_view.v_qa_deklarationsfehler_spr_zu_1 v01

GROUP BY 
 v01.qa_deklarationsfehler_id
,v01.mandant_id

UNION

SELECT 
 v01.mandant_id
,'-1'
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
FROM dbp_view.v_mandant_1 v01
 

;