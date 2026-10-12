create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_QA_DEKLARATIONSFEHLER_SPR_ZU(
	MANDANT_ID,
	QA_DEKLARATIONSFEHLER_ID,
	SPR_ID,
	QA_DEKLARATIONSFEHLER_BEZ
) as 
    SELECT 
        mandant_id,
        qa_deklarationsfehler_id,
        spr_id,
        qa_deklarationsfehler_bez

FROM DBP_DATA.QA_DEKLARATIONSFEHLER_SPR_ZU ;
