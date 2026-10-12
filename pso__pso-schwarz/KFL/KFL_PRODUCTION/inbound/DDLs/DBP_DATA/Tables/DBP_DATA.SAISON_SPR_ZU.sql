create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.SAISON_SPR_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	SAISON_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'ID der Saison aus saiso, z.Bsp 9',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	SAISON_BEZ VARCHAR(30) COLLATE 'en-ci' COMMENT 'Bezeichnung des Saisonkennzeichens, z.Bsp Sommer',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_SAISON_SPR_ZU primary key (MANDANT_ID, SAISON_ID, SPR_ID)
)COMMENT='AIS_KMO - Sprachabhängige Bezeichnungen der Saison'
;
