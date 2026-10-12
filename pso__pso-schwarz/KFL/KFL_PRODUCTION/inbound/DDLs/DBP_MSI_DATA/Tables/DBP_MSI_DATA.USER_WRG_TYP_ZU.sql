create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.USER_WRG_TYP_ZU (
	USER_ID VARCHAR(30) NOT NULL COLLATE 'en-ci' COMMENT 'ID des MSI Users',
	WRG_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'Es gibt zwei Typen der Währung - Land = 1 und Euro = 0',
	BERICHTSKURS_TYP_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Es gibt zwei Typen des Berichtskurs - aktueller Berichtskurs = 0 und historischer Berichtskurs = 1',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_USER_WRG_TYP_ZU primary key (USER_ID, WRG_TYP_ID)
)COMMENT='AIS_KMO - Zuordnung des FrontEnd-Users zu einem Währungstyp und Berichtskurstyp - über FrontEnd einstellbar.'
;
