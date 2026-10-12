CREATE TABLE DBP_DATA.L_WARENBEWEGUNGSTYP (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
	WARENBEWEGUNGSTYP_ID VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Warenbewegungstyp',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Lookup Warenbewegungstyp'
;