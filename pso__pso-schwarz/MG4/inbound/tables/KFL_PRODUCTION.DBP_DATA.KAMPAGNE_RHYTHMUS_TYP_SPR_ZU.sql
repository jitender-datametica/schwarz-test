create or replace TABLE KFL_PRODUCTION.DBP_DATA.KAMPAGNE_RHYTHMUS_TYP_SPR_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH.',
	KAMPAGNE_RHYTHMUS_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne.',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.',
	KAMPAGNE_RHYTHMUS_TYP_BEZ VARCHAR(200) NOT NULL COMMENT 'Bezeichnung der Art der Wiederholungshäufigkeit der Kampagne in unterschiedlichen Sprachen.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KAMPAGNE_RHYTHMUS_TYP_SPR_ZU primary key (MANDANT_ID, KAMPAGNE_RHYTHMUS_TYP_ID, SPR_ID)
)COMMENT='Sprachabhängige Bezeichnungen des Rhythmustyps der Kampagne - manuell versorgt.'
;