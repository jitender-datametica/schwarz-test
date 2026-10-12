CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_QA_MANGEL_SPR_ZU_1(
	MANDANT_ID,
	QA_MANGEL_ID,
	QA_MANGEL_BEZ,
	QA_MANGEL_BEZ_DE,
	QA_MANGEL_BEZ_CZ,
	QA_MANGEL_BEZ_SK,
	QA_MANGEL_BEZ_HR,
	QA_MANGEL_BEZ_PL,
	QA_MANGEL_BEZ_RO,
	QA_MANGEL_BEZ_BG
) AS
--2025-03-06,AP0205147, dknop, initial
SELECT
 v01.mandant_id
,v01.qa_mangel_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.qa_mangel_bez END) AS qa_mangel_bez                        -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.qa_mangel_bez END) AS qa_mangel_bez_de                               -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.qa_mangel_bez END), qa_mangel_bez_de ) AS qa_mangel_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.qa_mangel_bez END), qa_mangel_bez_de ) AS qa_mangel_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.qa_mangel_bez END), qa_mangel_bez_de ) AS qa_mangel_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.qa_mangel_bez END), qa_mangel_bez_de ) AS qa_mangel_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.qa_mangel_bez END), qa_mangel_bez_de ) AS qa_mangel_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.qa_mangel_bez END), qa_mangel_bez_de ) AS qa_mangel_bez_bg    -- BG

FROM dbp_view.v_qa_mangel_spr_zu_1 v01
GROUP BY v01.mandant_id
        ,v01.qa_mangel_id
UNION
SELECT 
 mandant_id
,'-1'
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL

FROM dbp_view.v_mandant_1
;