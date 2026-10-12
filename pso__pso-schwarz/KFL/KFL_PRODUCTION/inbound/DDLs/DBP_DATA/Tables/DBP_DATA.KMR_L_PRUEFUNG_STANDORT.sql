create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.KMR_L_PRUEFUNG_STANDORT (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
	STANDORT_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Standort-ID. Quellfeld auditing_location_id.',
	STANDORT_BEZ VARCHAR(255) NOT NULL DEFAULT ' ' COMMENT 'Standort-Bezeichnung. Quellfeld auditing_location_name.',
	STANDORT_TYP_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Standorttyp-ID. Quellfeld auditing_location_type_id.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_L_PRUEFUNG_STANDORT primary key (STANDORT_ID, AMX_SYSTEM_ID)
)COMMENT='KMR - Lookup table for the location (Standort), Does not include \""Kurzchecks\"". Source view v_dwh_kl_data_auditing.'
;
