create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_VERTRAGSART_SPR_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	VERTRAGSART_ID NUMBER(38,0) NOT NULL COMMENT 'Vertragsart',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	VERTRAGSART_BEZ VARCHAR(30) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung der Vertragsart',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_VERTRAGSART_SPR_ZU primary key (MANDANT_ID, VERTRAGSART_ID, SPR_ID)
)COMMENT='IMMO - Sprachabhängige Bezeichnung der Art des Vermietungsvertrags  - SAP REFX - TIV2F'
;