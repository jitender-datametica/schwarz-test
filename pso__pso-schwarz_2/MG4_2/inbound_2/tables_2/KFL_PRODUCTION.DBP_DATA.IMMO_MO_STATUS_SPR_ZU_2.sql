create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_MO_STATUS_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	MO_STATUS_ID NUMBER(38,0) NOT NULL COMMENT 'Status_2 ID des Mietobjekt',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	MO_STATUS_BEZ VARCHAR(30) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung Status_2  Mietobjekt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_MO_STATUS_SPR_ZU primary key (MANDANT_ID, MO_STATUS_ID, SPR_ID)
)COMMENT='IMMO - Sprachabhängige Bezeichungen des Status_2 des Mietobjekts (z.B. Leerstand, vermietet, übergeben) - SAP REFX - ZRE_FL_STATUST'
;