CREATE OR REPLACE TABLE MARKANT_TAGE_DISPO_MAP (
	ANZ_ARBEITSTAGE NUMBER(38,0) NOT NULL,
	ANZ_KALENDERTAGE_MO NUMBER(38,0),
	ANZ_KALENDERTAGE_DI NUMBER(38,0),
	ANZ_KALENDERTAGE_MI NUMBER(38,0),
	ANZ_KALENDERTAGE_DO NUMBER(38,0),
	ANZ_KALENDERTAGE_FR NUMBER(38,0),
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);