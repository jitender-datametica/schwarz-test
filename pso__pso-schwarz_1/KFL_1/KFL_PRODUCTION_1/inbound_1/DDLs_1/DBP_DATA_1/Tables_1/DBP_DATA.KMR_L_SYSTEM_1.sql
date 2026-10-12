create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.KMR_L_SYSTEM_1 (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
	AMX_SYSTEM_BEZ VARCHAR(20) NOT NULL DEFAULT ' ' COMMENT 'Bezeichnung der unterschiedlichen AMX Systeme. Kein Quellfeld im View. Wird per Hand befüllt.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_L_SYSTEM primary key (AMX_SYSTEM_ID)
)COMMENT='KMR - Lookup table for the different AMX source systems (Core vs. Unternehmenssicherheit). Source view v_dwh_kl_data_auditing.'
;
