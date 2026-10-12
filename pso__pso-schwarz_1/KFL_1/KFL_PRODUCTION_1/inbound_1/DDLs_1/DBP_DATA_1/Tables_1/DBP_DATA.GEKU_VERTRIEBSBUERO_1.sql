create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.GEKU_VERTRIEBSBUERO_1 (
	VERTRIEBSBUERO_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID eines Vertriebsbüros aus rvl_nr',
	COUNTRY_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID des Landes aus country_nr',
	VERTRIEBSBUERO_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Bezeichnung des Vertriebsbüros',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_VERTRIEBSBUERO primary key (VERTRIEBSBUERO_UID)
)COMMENT='GEKU - Lookup Tabelle der Vertriebsbüros aus wmd_rvl_out'
;
