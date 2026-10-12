CREATE TABLE DBP_DATA.LAGERPROZESSTYP_SPR_ZU_1 (
	LAGERPROZESSTYP_ID VARCHAR(1) NOT NULL COMMENT 'Lagerprozesstyp',
	SPR_ID INTEGER NOT NULL COMMENT 'ID der Sprache',
	LAGERPROZESSTYP_BEZ VARCHAR(40) COMMENT 'Lagerprozesstyp Bezeichnung',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Lagerprozesstyp Bezeichnung'
;