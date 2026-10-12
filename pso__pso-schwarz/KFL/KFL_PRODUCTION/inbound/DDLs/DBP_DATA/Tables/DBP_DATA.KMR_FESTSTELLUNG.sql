create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.KMR_FESTSTELLUNG (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
	FESTSTELLUNG_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Feststellung-ID. Quellfeld issue_id.',
	FRAGE_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Frage-ID. Quellfeld guideline_id. Eindeutige ID einer überprüften Frage.',
	FESTSTELLUNG_BEZ VARCHAR(255) DEFAULT ' ' COMMENT 'Feststellung-Bezeichnung. Quellfeld issue_title.',
	FESTSTELLUNG_TEXT VARCHAR(50000) COMMENT 'Feststellungsbeobachtung Text. Formfrei, somit sind Länge und Inhalt dem Reviewer überlassen. Quellfeld issue_observation.',
	FESTSTELLUNG_GEWICHTUNG_ID NUMBER(38,0) DEFAULT -1 COMMENT 'Gewichtung-ID. Quellfeld issue_weight_id.',
	COMPLIANCE_FG NUMBER(38,0) COMMENT 'Flag: Ist Compliance-Feststellung. Quellfeld issue_is_compliance.',
	BERICHTSRELEVANT_FG NUMBER(38,0) COMMENT 'Flag: Ist berichtsrelevante Feststellung. Quellfeld issue_is_report_relevant.',
	EFFIZIENZ_FG NUMBER(38,0) COMMENT 'Flag: Ist Effizienz-Feststellung. Quellfeld issue_is_efficiency.',
	WIEDERKEHREND_FG NUMBER(38,0) COMMENT 'Flag: Ist wiederholte Feststellung. Quellfeld issue_is_repeat_issue.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_FESTSTELLUNG primary key (AMX_SYSTEM_ID, FESTSTELLUNG_ID)
)COMMENT='KMR - This table contains all issues (feststellung_id) that were observed with the guideline (frage_id) that was audited. Does not contain \""Kurzchecks\"". Source view v_dwh_kl_data_issue.'
;
