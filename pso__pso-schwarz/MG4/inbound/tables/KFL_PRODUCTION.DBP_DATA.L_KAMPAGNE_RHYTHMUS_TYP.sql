create or replace TABLE KFL_PRODUCTION.DBP_DATA.L_KAMPAGNE_RHYTHMUS_TYP (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH.',
	KAMPAGNE_RHYTHMUS_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne, z. B. 0 = Recurring, 1 = Ongoing, 2 = OneTime, 3 = Event.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_L_KAMPAGNE_RHYTHMUS_TYP primary key (MANDANT_ID, KAMPAGNE_RHYTHMUS_TYP_ID)
)COMMENT='Die Tabelle dient zur Kategorisierung und Klassifizierung verschiedener Arten von Rhythmen, die den Start einer Kampagne auslösen können.'
;