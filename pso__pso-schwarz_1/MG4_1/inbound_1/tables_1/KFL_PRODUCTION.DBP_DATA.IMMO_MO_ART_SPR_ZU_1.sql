create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_MO_ART_SPR_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	MO_ART_KZ VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichen der Flächenart (Mietobjekt)',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	MO_ART_BEZ VARCHAR(40) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung der Flächenart (Mietobjekt) (z.B. Expansions-,Umbau-, Normalfläche etc.)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_MO_ART_SPR_ZU primary key (MANDANT_ID, MO_ART_KZ, SPR_ID)
)COMMENT='IMMO - Sprachabhängige Bezeichnung für die Flächenart (Mietobjekt) - SAP REFX - ZRE_FLAECHENARTT'
;