create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_KMR_MASSNAHME_ANTRAG_2(
	AMX_SYSTEM_ID,
	MASSNAHME_ID,
	AUDITEE_LETZTER_ANTRAG_ID,
	AUDITEE_LETZTER_ANTRAG_BEZ,
	DAT_AUDITEE_LETZTER_ANTRAG,
	AUDITOR_LETZTE_ANTWORT_ID,
	AUDITOR_LETZTE_ANTWORT_BEZ,
	DAT_AUDITOR_LETZTE_ANTWORT
) as
-- 20230124 twie: SPEC0173748 neue audimex View für Massnahme Antrag
--				  PK ist wie bei kmr_massnahme_2 die massnahme_id, es wird nur der letzte Status_2 einer Massnahme gespeichert

SELECT 

 amx_system_id
,massnahme_id
,auditee_letzter_antrag_id
,auditee_letzter_antrag_bez
,dat_auditee_letzter_antrag
,auditor_letzte_antwort_id
,auditor_letzte_antwort_bez
,dat_auditor_letzte_antwort

FROM dbp_view.V_KMR_MASSNAHME_ANTRAG_2;