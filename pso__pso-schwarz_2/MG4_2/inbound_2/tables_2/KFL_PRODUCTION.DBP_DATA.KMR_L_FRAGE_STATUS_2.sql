create or replace TABLE KFL_PRODUCTION.DBP_DATA.KMR_L_FRAGE_STATUS_2 (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
	FRAGE_STATUS_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Status_2-ID. Quellfeld guideline_state_id.',
	FRAGE_STATUS_BEZ VARCHAR(255) NOT NULL DEFAULT ' ' COMMENT 'Status_2-Bezeichnung. Quellfeld guideline_state_name.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_L_FRAGE_STATUS primary key (FRAGE_STATUS_ID, AMX_SYSTEM_ID)
)COMMENT='KMR - Lookup table for the status_2 of a question / guideline check during the audit process. Does not contain \"Kurzchecks\". Source view v_dwh_kl_data_guideline.'
;