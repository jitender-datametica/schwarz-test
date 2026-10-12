create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.BEST_ENTW_TYP_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Der Mandant_2 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
	BEST_ENTW_TYP_ID VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichen über die Art_2 des Folgebeleges: \n            E = Wareneingang, Lagerbewegung, U = Warenausgang, Lagerbewegung, L = Lieferschein',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
	BEST_ENTW_TYP_KBEZ VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung des Bestell-Entwicklungstyps aus t163c.bewtk',
	BEST_ENTW_TYP_BEZ VARCHAR(20) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Dieses Feld enthält die Kurztexte der Typen der Bestellentwicklung.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BEST_ENTW_TYP_SPR_ZU primary key (MANDANT_ID, BEST_ENTW_TYP_ID, SPR_ID)
)COMMENT='TP408_LVS - In dieser Tabelle sind die sprachabhängigen Kurztexte für die Belegtypen der Bestellungen enthalten aus t163'
;
