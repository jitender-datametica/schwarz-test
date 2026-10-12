create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_L_VERTRAGSART (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	VERTRAGSART_ID NUMBER(38,0) NOT NULL COMMENT 'Vertragsart',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_L_VERTRAGSART primary key (MANDANT_ID, VERTRAGSART_ID)
)COMMENT='IMMO - Art des Vermietungsvertrags  - SAP REFX - TIV2F'
;