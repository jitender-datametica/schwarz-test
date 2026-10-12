create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_QA_DEKLARATIONSFEHLER(
	MANDANT_ID,
	QA_DEKLARATIONSFEHLER_ID,
	AKTIV_FG,
	PFLANZEN_FG
) as
--2025-03-06,AP0205147, dknop, initial
SELECT
 mandant_id
,qa_deklarationsfehler_id
,aktiv_fg
,pflanzen_fg
FROM dbp_view.v_l_qa_deklarationsfehler
UNION
SELECT 
 v01.mandant_id
,'-1'
,-1
,-1

FROM dbp_view.v_mandant v01;