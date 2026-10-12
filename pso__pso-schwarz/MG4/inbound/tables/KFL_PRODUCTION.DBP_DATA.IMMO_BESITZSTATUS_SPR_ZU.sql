create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_BESITZSTATUS_SPR_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	BESITZSTATUS_ID VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Besitzstatus ',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	BESITZSTATUS_BEZ VARCHAR(40) NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung Besitzstatus',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_BESITZSTATUS_SPR_ZU primary key (MANDANT_ID, BESITZSTATUS_ID, SPR_ID)
)COMMENT='IMMO - Sprachabhängige Bezeichnungen des Besitzstatus der Wirtschaftseinheit - SAP REFX - ZRE_BESITZSTATT'
;