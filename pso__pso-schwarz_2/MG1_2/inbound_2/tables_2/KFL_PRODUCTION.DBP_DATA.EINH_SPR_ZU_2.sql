create or replace TABLE KFL_PRODUCTION.DBP_DATA.EINH_SPR_ZU_2 (
	EINH_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Masseinheit aus der Spalte msehi, zum Beispiel  %',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache\n            ',
	EINH_BEZ_KAUFM VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'externe Masseinheit kaufmaännische Darstellung aus mseh3',
	EINH_BEZ VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Kurztext der Masseinheiten Bezeichnung aus mseht (z.Bsp. Prozent)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_EINH_SPR_ZU primary key (EINH_ID, MANDANT_ID, SPR_ID)
)COMMENT='AIS - Sprachabhängige Bezeichnungen der Einheiten (für Einkauf) aus t006a'
;