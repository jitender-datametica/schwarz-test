create or replace TABLE KFL_PRODUCTION.DBP_DATA.KOMMUNIKATIONSKANAL_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	KOMMUNIKATIONSKANAL_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige Kennung des Kommunikationskanals',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der DWH-Sprache, z.B. 22 ist Deutsch',
	KOMMUNIKATIONSKANAL_BEZ VARCHAR(200) NOT NULL COMMENT 'Übersetzung des Kanalnamens oder der Kanalbeschreibung in die jeweilige Sprache, z. B. 1 = E-Mail, 2 = Push Notification, 3 = SMS',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KOMMUNIKATIONSKANAL_SPR_ZU primary key (MANDANT_ID, KOMMUNIKATIONSKANAL_ID, SPR_ID)
)COMMENT='Sprachabhängige Bezeichnungen der Kommunikationskanäle für Marketingkampagnen - manuell versorgt'
;