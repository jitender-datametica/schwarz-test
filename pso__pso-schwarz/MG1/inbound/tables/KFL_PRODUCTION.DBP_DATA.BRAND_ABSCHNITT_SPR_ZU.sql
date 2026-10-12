create or replace TABLE KFL_PRODUCTION.DBP_DATA.BRAND_ABSCHNITT_SPR_ZU (
	BRAND_ABSCHNITT_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'ID des Brandabschnitts aus brand',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
	LAGERNUMMER_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
	BRAND_ABSCHNITT_BEZ VARCHAR(20) COLLATE 'en-ci' COMMENT 'Bezeichnung des Brandabschnitts aus brant',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BRAND_ABSCHNITT_SPR_ZU primary key (BRAND_ABSCHNITT_ID, MANDANT_ID, LAGERNUMMER_ID, SPR_ID)
)COMMENT='LIS - Sprachabhängige Bezeichnungen der Brandabschnitte aus t309t'
;