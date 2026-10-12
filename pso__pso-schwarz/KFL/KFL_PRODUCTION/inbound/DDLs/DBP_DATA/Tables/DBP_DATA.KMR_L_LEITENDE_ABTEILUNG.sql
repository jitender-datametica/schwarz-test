create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.KMR_L_LEITENDE_ABTEILUNG (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
	LEIT_ABTEILUNG_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Leitende Abteilung-ID. Quellfeld auditing_leading_dep_id.',
	LEIT_ABTEILUNG_BEZ VARCHAR(255) NOT NULL DEFAULT ' ' COMMENT 'Leitende Abteilung-Bezeichnung. Quellfeld auditing_leading_dep_name.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_L_LEITENDE_ABTEILUNG primary key (LEIT_ABTEILUNG_ID, AMX_SYSTEM_ID)
)COMMENT='KMR - Lookup table for the leading department (leitende Abteilung). Department that initiates the audit, i.e. Revision Kaufland International, Bulgaria, etc. Does not include \""Kurzchecks\"". Source view v_dwh_kl_data_auditing.'
;
