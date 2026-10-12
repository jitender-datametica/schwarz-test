CREATE OR REPLACE TABLE MARKANT_TAGE_DISPO_MAP_1 (
	ANZ_ARBEITSTAGE INTEGER NOT NULL,
	ANZ_KALENDERTAGE_MO INTEGER,
	ANZ_KALENDERTAGE_DI INTEGER,
	ANZ_KALENDERTAGE_MI INTEGER,
	ANZ_KALENDERTAGE_DO INTEGER,
	ANZ_KALENDERTAGE_FR INTEGER,
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);