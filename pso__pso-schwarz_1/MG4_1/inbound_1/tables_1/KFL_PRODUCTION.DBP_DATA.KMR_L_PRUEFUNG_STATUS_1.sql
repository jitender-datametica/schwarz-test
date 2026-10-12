create or replace TABLE KFL_PRODUCTION.DBP_DATA.KMR_L_PRUEFUNG_STATUS_1 (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
	PRUEFUNG_STATUS_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Prüfungsstatus-ID. Quellfeld auditing_state.',
	PRUEFUNG_STATUS_BEZ VARCHAR(255) NOT NULL DEFAULT ' ' COMMENT 'Prüfungsstatus-Bezeichnung. Quellfeld auditing_state_name.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_L_PRUEFUNG_STATUS primary key (PRUEFUNG_STATUS_ID, AMX_SYSTEM_ID)
)COMMENT='KMR - Lookup table for the auditing state (Pruefungsstatus). Does not include \"Kurzchecks\". Source view v_dwh_kl_data_auditing.'
;