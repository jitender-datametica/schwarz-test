CREATE TABLE DBP_DATA.LAGERPROZESSART_SPR_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COMMENT 'Lagernummer',
	LAGERPROZESSART_ID VARCHAR(4) NOT NULL COMMENT 'Lagerprozessart',
	LAGERPROZESSART_BEZ VARCHAR(40) COMMENT 'Lagerprozessart Bezeichnung',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Lagerprozessart Bezeichnung'
;