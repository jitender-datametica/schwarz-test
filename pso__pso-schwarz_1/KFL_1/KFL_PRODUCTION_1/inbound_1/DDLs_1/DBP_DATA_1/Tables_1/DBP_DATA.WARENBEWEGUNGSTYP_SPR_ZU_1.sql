CREATE TABLE DBP_DATA.WARENBEWEGUNGSTYP_SPR_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WARENBEWEGUNGSTYP_ID VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Warenbewegungstyp',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Sprachschlüssel',
	WARENBEWEGUNGSTYP_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Bez. Warenbewegungstyp',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Beschreibung Warenbewegungstyp'
;