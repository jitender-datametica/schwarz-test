CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_CHARGE_IST_SOLL_QA_CHECK_DET(
	CHARGE_NR_QA,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	QA_MANGEL_ID,
	QA_DEKLARATIONSFEHLER_ID,
	KOMMENTAR_QA_TXT,
	KOMMENTAR_EK_TXT
) AS
--2025-03-06,AP0205147, dknop, initial
 
 SELECT
  v01.charge_nr_qa
,v01.mandant_id
,v01.wup_id
,v01.nb_id
,COALESCE (v04.qa_mangel_id,'-1') AS qa_mangel_id
,COALESCE (v04.qa_deklarationsfehler_id,'-1') AS qa_deklarationsfehler_id
,v04.kommentar_qa_txt
,v04.kommentar_ek_txt
  FROM dbp_view.v_charge_ist_qa_check v01
  LEFT JOIN dbp_view.v_charge_ist_qa_check_det v04
  ON v01.charge_nr_qa = v04.charge_nr_qa
  AND v01.mandant_id = v04.mandant_id ;