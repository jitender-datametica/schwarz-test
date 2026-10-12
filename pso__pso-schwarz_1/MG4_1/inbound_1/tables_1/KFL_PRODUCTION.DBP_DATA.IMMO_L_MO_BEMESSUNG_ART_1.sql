create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_L_MO_BEMESSUNG_ART_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	BEMESSUNG_ART_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Bemessungsart',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_L_MO_BEMESSUNG_ART primary key (MANDANT_ID, BEMESSUNG_ART_ID)
)COMMENT='IMMO - Lookup Tabelle für die Bemessungsart (Mietobjekt) - SAP REFX - TIVBDMEAST'
;