create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW3.USER_PRJ_WRG_TYP_ZU (
	USER_ID VARCHAR(120) NOT NULL COLLATE 'en-ci' COMMENT 'ID des MSI Users',
	WRG_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'Es gibt zwei Typen der Währung - Land = 1 und Euro = 0',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9),
	unique (USER_ID)
)COMMENT='Zuordnung des FrontEnd-Users zu einem Währungstyp fuer das LIS MSTR-Projekt - über FrontEnd einstellbar'
;
