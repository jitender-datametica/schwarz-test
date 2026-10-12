create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.KMR_L_PRUEFUNG_KLASSE_2 (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
	PRUEFUNG_KLASSE_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Prüfungsklasse / -art_2-ID. Quellfeld auditing_auditing_class_id.',
	PRUEFUNG_KLASSE_BEZ VARCHAR(255) NOT NULL DEFAULT ' ' COMMENT 'Prüfungsklasse / -art_2-Bezeichnung. Quellfeld auditing_auditing_class_name.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_L_PRUEFUNG_KLASSE primary key (PRUEFUNG_KLASSE_ID, AMX_SYSTEM_ID)
)COMMENT='KMR - Lookup table for the audit class (Pruefungsklasse/-art_2). Does not include \""Kurzchecks\"". Source view v_dwh_kl_data_auditing.'
;
