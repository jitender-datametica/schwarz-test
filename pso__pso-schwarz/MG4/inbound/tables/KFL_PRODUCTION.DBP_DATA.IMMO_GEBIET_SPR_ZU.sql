create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_GEBIET_SPR_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	GEBIET_ID NUMBER(38,0) NOT NULL COMMENT 'Gebiet ID',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	GEBIET_BEZ VARCHAR(30) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung Gebiet ',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_GEBIET_SPR_ZU primary key (MANDANT_ID, GEBIET_ID, SPR_ID)
)COMMENT='IMMO - Sprachabhängige Tabelle für Gebiete - SAP REFX - ZTB0000VZOP9OT'
;