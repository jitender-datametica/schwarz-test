create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.KMR_L_FESTSTELLUNG_GEWICHTUNG_2 (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
	FESTSTELLUNG_GEWICHTUNG_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Gewichtung-ID. Quellfeld issue_weight_id.',
	FESTSTELLUNG_GEWICHTUNG_BEZ VARCHAR(255) NOT NULL DEFAULT ' ' COMMENT 'Gewichtung-Bezeichnung. Quellfeld issue_weight_name.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_L_FESTSTELLUNG_GEWICHTUNG primary key (FESTSTELLUNG_GEWICHTUNG_ID, AMX_SYSTEM_ID)
)COMMENT='KMR - Lookup table for the weight / importance of the issue (light, medium, heavy). Does not contain \""Kurzchecks\"". Source view v_dwh_kl_data_issue.'
;
