create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_L_THEMENBAUM_LV2_2 (
	CRM_THEMENBAUM_LV2_ID VARCHAR(36) NOT NULL COLLATE 'en-ci' COMMENT 'Themenbaum Id',
	CRM_THEMENBAUM_LV1_ID VARCHAR(36) COLLATE 'en-ci' COMMENT 'Zugehörigkeit zu einem höheren Themnbaum Eintrag',
	EBENE_1_ID NUMBER(38,0) COMMENT 'Für DWH BSI Mapping 2. Stuffe (Entspricht GEKU Bereich)',
	EBENE_2_ID NUMBER(38,0) COMMENT 'Für DWH BSI Mapping 3. Stuffe (Entspricht GEKU Grund)',
	EBENE_3_ID NUMBER(38,0) COMMENT 'Für DWH BSI Mapping 1. Stuffe Entspricht GEKU DWH Artikel_2)',
	NUMBER_LEVEL_1 VARCHAR(15) COLLATE 'en-ci' COMMENT 'number_level_1',
	NUMBER_LEVEL_2 VARCHAR(15) COLLATE 'en-ci' COMMENT 'number_level_2',
	NUMBER_LEVEL_3 VARCHAR(15) COLLATE 'en-ci' COMMENT 'number_level_3',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_L_THEMENBAUM_LV2 primary key (CRM_THEMENBAUM_LV2_ID)
)COMMENT='KMR - Enthält Themenbaumeiträge der Ebene 2 (unterste Granularitätsebene) - MS Dynamics CRM'
;