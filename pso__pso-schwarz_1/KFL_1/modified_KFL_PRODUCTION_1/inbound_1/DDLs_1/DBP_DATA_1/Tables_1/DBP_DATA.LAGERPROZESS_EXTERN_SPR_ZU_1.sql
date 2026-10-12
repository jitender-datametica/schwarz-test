CREATE TABLE DBP_DATA.LAGERPROZESS_EXTERN_SPR_ZU_1 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_1 im DWH',
	LAGERPROZESS_EXTERN_ID VARCHAR(4) NOT NULL COMMENT 'Externer Lagerungsprozessschritt',
	SPR_ID INTEGER NOT NULL COMMENT 'ID der Sprache',
	LAGERPROZESS_EXTERN_BEZ VARCHAR(40) COMMENT 'Bezeichnung',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Externer Lagerprozess - Beschreibung'
;