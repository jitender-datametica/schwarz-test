create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_KMR_MASSNAHME_ANTRAG_2(
	AMX_SYSTEM_ID,
	MASSNAHME_ID,
	AUDITEE_LETZTER_ANTRAG_ID,
	AUDITEE_LETZTER_ANTRAG_BEZ,
	DAT_AUDITEE_LETZTER_ANTRAG,
	AUDITOR_LETZTE_ANTWORT_ID,
	AUDITOR_LETZTE_ANTWORT_BEZ,
	DAT_AUDITOR_LETZTE_ANTWORT
) as 
    SELECT 
        amx_system_id
        ,massnahme_id
        ,auditee_letzter_antrag_id
        ,auditee_letzter_antrag_bez
        ,dat_auditee_letzter_antrag
        ,auditor_letzte_antwort_id
        ,auditor_letzte_antwort_bez
        ,dat_auditor_letzte_antwort


FROM DBP_DATA.KMR_MASSNAHME_ANTRAG_2 ;
