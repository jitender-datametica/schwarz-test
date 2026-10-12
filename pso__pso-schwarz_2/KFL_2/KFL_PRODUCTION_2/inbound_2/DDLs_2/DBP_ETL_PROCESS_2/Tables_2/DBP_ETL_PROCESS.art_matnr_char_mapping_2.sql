CREATE OR REPLACE TABLE ART_MATNR_CHAR_MAPPING_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	KL_ART_ID NUMBER(38,0) NOT NULL COMMENT '7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer',
	MATNR_CHAR VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'Alphanummerisch Artikelnummer aus dem Quellsystem (matnr)',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);