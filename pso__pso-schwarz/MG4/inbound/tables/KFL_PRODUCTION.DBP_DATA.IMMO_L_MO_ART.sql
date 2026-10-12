create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_L_MO_ART (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	MO_ART_KZ VARCHAR(1) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Kennzeichen der Flächenart (Mietobjekt)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_L_MO_ART primary key (MANDANT_ID, MO_ART_KZ)
)COMMENT='IMMO - Lookup Tabelle für die Flächenart (Mietobjekt) - SAP REFX - ZRE_FLAECHENARTT'
;