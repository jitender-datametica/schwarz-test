create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.BUCHUNGSKREIS_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Der Mandant_2 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
	BUCHUNGSKREIS_ID NUMBER(38,0) NOT NULL COMMENT 'Zuordnung des Buchungskreises zu dem WUP_2 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_2, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	BUCHUNGSKREIS_BEZ VARCHAR(30) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'In diesem Feld sind die Kurztexte für die Buchungskreise in Abhängigkeit von der Sprache hinterlegt.',
	STRASSE VARCHAR(60) COLLATE 'en-ci' COMMENT 'Strasse der Firma aus der Quelle adrc.street',
	PLZ VARCHAR(10) COLLATE 'en-ci' COMMENT 'Postleitzahl aus adrc.postcode1',
	ORT VARCHAR(80) COLLATE 'en-ci' COMMENT 'Ort aus adrc.city1/city2',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BUCHUNGSKREIS_SPR_ZU primary key (MANDANT_ID, BUCHUNGSKREIS_ID, SPR_ID, SYSTEM_ID)
)COMMENT='TP408_LVS - In dieser Tabelle sind die spachabhängigen Kurztexte der Buchungskreise aus der SAP Tabelle T001_2 enthalten - MULTISET.'
;
