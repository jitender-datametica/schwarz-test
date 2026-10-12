CREATE OR REPLACE TABLE ZSKMDCLCUWERKS_2 (
	MANDT VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Mandant_2 im SAP',
	MTART VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Materialart',
	WERKS VARCHAR(4) COLLATE 'en-ci' COMMENT 'Werk',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);