create or replace TABLE KFL_PRODUCTION.DBP_DATA.KMR_L_FRAGE_TYP_2 (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
	FRAGE_TYP_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Fragetyp-ID. Quellfeld guideline_checklist_logic_id.',
	FRAGE_TYP_BEZ VARCHAR(255) NOT NULL DEFAULT ' ' COMMENT 'Fragetyp-Bezeichnung. Quellfeld guideline_checklist_logic_name.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_L_FRAGE_TYP primary key (FRAGE_TYP_ID, AMX_SYSTEM_ID)
)COMMENT='KMR - Lookup table for the type of question / guideline. Does not contain \"Kurzchecks\". Source view v_dwh_kl_data_guideline.'
;