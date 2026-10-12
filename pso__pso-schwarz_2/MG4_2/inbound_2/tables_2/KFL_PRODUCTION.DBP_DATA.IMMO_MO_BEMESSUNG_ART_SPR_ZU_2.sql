create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_MO_BEMESSUNG_ART_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	BEMESSUNG_ART_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Bemessungsart',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	BEMESSUNG_ART_BEZ VARCHAR(30) NOT NULL COLLATE 'en-ci' DEFAULT ' ',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_MO_BEMESSUNG_ART_SPR_ZU primary key (MANDANT_ID, BEMESSUNG_ART_ID, SPR_ID)
)COMMENT='IMMO - Sprachabhängige Bezeichnung für die Bemessungsart (Mietobjekt) - SAP REFX - TIVBDMEAST'
;