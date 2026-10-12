CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_QA_MANGEL_2(
	MANDANT_ID,
	QA_MANGEL_ID,
	PFLANZEN_FG,
	QA_PRIO
) AS
--2025-03-06,AP0205147, dknop, initial
SELECT
 mandant_id
,qa_mangel_id
,pflanzen_fg
,qa_prio
FROM dbp_view.v_l_qa_mangel_2
UNION
SELECT 
 mandant_id
,'-1'
,-1
,-1
FROM dbp_view.v_mandant_2
;