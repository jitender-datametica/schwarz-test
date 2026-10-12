create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.KMR_MASSNAHME_ANTRAG_2 (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
	MASSNAHME_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Maßnahme-ID. Quellfeld suggestion_id.',
	AUDITEE_LETZTER_ANTRAG_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Jüngste Antrag-ID vom Geprüften / Auditee bezüglich einer Maßnmahme. Ein vorheriger Antrag wird überschrieben / gelöscht. Quellfeld reaction_id_auditee.',
	AUDITEE_LETZTER_ANTRAG_BEZ VARCHAR(255) DEFAULT ' ' COMMENT 'Jüngste Antrag-Bezeichnung bezüglich einer Maßnahme. Quellfeld reaction_type_auditee.',
	DAT_AUDITEE_LETZTER_ANTRAG DATE COMMENT 'Datum der jüngsten Antwort bezüglich einer Maßnahme. Quellfeld reaction_date_auditee.',
	AUDITOR_LETZTE_ANTWORT_ID NUMBER(38,0) DEFAULT -1 COMMENT 'Jüngste Antwort-ID, Prüfer / Auditor. Quellfeld reaction_id_auditor.',
	AUDITOR_LETZTE_ANTWORT_BEZ VARCHAR(255) DEFAULT ' ' COMMENT 'Jüngste Antwort-Bezeichnung auf Antrag zu einer Maßnahme. Quellfeld reaction_type_auditor.',
	DAT_AUDITOR_LETZTE_ANTWORT DATE COMMENT 'Datum der jüngsten Antwort auf Antrag zu einer Maßnahme. Quellfeld reaction_date_auditor.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_MASSNAHME_ANTRAG primary key (AMX_SYSTEM_ID, MASSNAHME_ID)
)COMMENT='KMR - Delete / insert transactional snapshot_2 of the current date minus 365 days. This table contains the latest communication_2 (at the date of loading) regarding a suggestion (Maßnahme) and its response, between auditee and auditor. An auditee can make a request (Antrag stellen) regarding the suggestion (Maßnahme) that the auditor defined for an issue found during auditing (Feststellung in einer Prüfung). Requests include time extensions, change or closing of the issue, or no implementaton, and the auditor can approve or decline them. This data is not historized but built in order to fit reporting requirements as discussed with BC at creation. Only the most recent request and answer regarding a suggestion are loaded each day, meaning that previous antrag_ids and antwort_ids in the source were overwritten / deleted (when there is only a request with no answer yet, then the answer columns will be empty / have default values). Source view v_dwh_kl_data_reaction.'
;
