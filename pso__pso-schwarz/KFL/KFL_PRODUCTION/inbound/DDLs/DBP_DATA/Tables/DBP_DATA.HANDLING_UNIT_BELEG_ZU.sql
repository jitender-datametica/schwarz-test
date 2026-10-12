CREATE TABLE DBP_DATA.HANDLING_UNIT_BELEG_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	QUELLE VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Quelltabelle SAP',
	LOG_GUID VARCHAR(32) NOT NULL COMMENT 'Warenbewegungslog HU',
	HANDLING_UNIT_GUID VARCHAR(32) NOT NULL COMMENT 'Handling Unit GUID',
	BELEG_GUID VARCHAR(32) NOT NULL COMMENT 'Beleg-ID',
	BELEGTYP_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Belegtyp',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='HU-Beleg Referenz EWM'
;