CREATE TABLE DBP_DATA.EWM_STATUS_SPR_ZU (
	STATUS_ID VARCHAR(5) NOT NULL COMMENT 'Status ID',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	STATUS_SCHEMA_ID VARCHAR(8) NOT NULL COMMENT 'Statusschema',
	STATUS_KBEZ VARCHAR(4) COMMENT 'Statustext (kurz)',
	STATUS_BEZ VARCHAR(30) COMMENT 'Statustext (lang)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='EWM Status'
;