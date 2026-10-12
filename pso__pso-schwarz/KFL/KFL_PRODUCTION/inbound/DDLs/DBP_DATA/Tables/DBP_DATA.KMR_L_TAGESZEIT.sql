create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.KMR_L_TAGESZEIT (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
	TAGESZEIT_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Tageszeit-ID. Beinhaltet früh, mittel, oder spät. Quellfeld auditing_reserve_sel_auditing_00_id.',
	TAGESZEIT_BEZ VARCHAR(80) NOT NULL DEFAULT ' ' COMMENT 'Tageszeit-Bezeichnung. Beinhaltet früh, mittel, oder spät. Quellfeld auditing_reserve_sel_auditing_00_name.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_L_TAGESZEIT primary key (TAGESZEIT_ID, AMX_SYSTEM_ID)
)COMMENT='KMR - Lookup table for the time of the day during which an audit is performed (Tageszeit). Does not include \""Kurzchecks\"". Source view v_dwh_kl_data_auditing.'
;
