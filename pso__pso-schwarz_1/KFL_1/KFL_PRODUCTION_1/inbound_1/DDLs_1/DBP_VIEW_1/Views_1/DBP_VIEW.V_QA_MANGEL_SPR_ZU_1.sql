create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_QA_MANGEL_SPR_ZU_1(
	MANDANT_ID,
	QA_MANGEL_ID,
	SPR_ID,
	QA_MANGEL_BEZ
) as 
    SELECT 
        mandant_id,
        qa_mangel_id,
        spr_id,
        qa_mangel_bez

FROM DBP_DATA.QA_MANGEL_SPR_ZU_1 ;
