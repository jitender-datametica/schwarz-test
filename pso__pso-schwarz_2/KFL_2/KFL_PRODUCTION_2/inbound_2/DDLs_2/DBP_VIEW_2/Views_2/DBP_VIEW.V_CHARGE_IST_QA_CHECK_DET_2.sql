create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_CHARGE_IST_QA_CHECK_DET_2(
	MANDANT_ID,
	SEQ_NR,
	CHARGE_NR_QA,
	QA_MANGEL_ID,
	QA_DEKLARATIONSFEHLER_ID,
	KOMMENTAR_QA_TXT,
	KOMMENTAR_EK_TXT
) as 
    SELECT 
        mandant_id,
        seq_nr,
        charge_nr_qa,
        qa_mangel_id,
        qa_deklarationsfehler_id,
        kommentar_qa_txt,
        kommentar_ek_txt

FROM DBP_DATA.CHARGE_IST_QA_CHECK_DET_2 ;
