CREATE TABLE DBP_DATA.AKTIVITAETSBEREICH_SPR_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COMMENT 'Lagernummer',
	AKTIVITAETSBEREICH_ID VARCHAR(4) NOT NULL COMMENT 'Aktivitätsbereich',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	AKTIVITAETSBEREICH_BEZ VARCHAR(40) COMMENT 'Bezeichnung',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Aktivitätsbereich - Bezeichnung'
;