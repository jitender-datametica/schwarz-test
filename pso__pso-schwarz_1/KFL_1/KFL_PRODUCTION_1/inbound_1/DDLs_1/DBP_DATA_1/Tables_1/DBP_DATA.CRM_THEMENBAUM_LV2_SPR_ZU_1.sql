create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CRM_THEMENBAUM_LV2_SPR_ZU_1 (
	CRM_THEMENBAUM_LV2_ID VARCHAR(36) NOT NULL COLLATE 'en-ci' COMMENT 'Themenbaum Id',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	EBENE_1_ID NUMBER(38,0) NOT NULL COMMENT 'Für DWH BSI Mapping 2. Stuffe (Entspricht GEKU Bereich)',
	EBENE_2_ID NUMBER(38,0) NOT NULL COMMENT 'Für DWH BSI Mapping 3. Stuffe (Entspricht GEKU Grund)',
	EBENE_3_ID NUMBER(38,0) NOT NULL COMMENT 'Für DWH BSI Mapping 1. Stuffe Entspricht GEKU DWH Artikel_1)',
	EBENE_1_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Text für key_level_1 / Text für GEKU Bereich',
	EBENE_2_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Name des aktuellen Themnbaumlevels / Text für GEKU Grund',
	EBENE_3_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Text für key_level_2 / Text enstpricht GEKU DWH Artikel_1',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_THEMENBAUM_LV2_SPR_ZU primary key (CRM_THEMENBAUM_LV2_ID, SPR_ID, EBENE_1_ID, EBENE_2_ID, EBENE_3_ID)
)COMMENT='KMR - Enthält Themenbaumeiträge der Ebene 2 (unterste Granularitätsebene) - MS Dynamics CRM'
;
