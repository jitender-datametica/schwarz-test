create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_MIETVERTRAG_UMSATZVEREINBARUNG_PER_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	MV_INTRENO VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'Interner Schlüssel des Immobilienobjekts',
	MELDEREGEL VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Klauselnummer der Melderegel',
	VERSION VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Version einer Umsatzmeldung',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Datum an dem die Umsatzmeldung eingegangen ist',
	RHYTHMUS_ART VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Rhythmusart',
	DAT_MELDUNGSINTERVALL_VON DATE NOT NULL COMMENT 'Beginn Meldungsintervall für Umsatzmietvertrag',
	DAT_MELDUNGSINTERVALL_BIS DATE NOT NULL COMMENT 'Ende Meldungsintervall für Umsatzmietvertrag',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Währungsschlüssel',
	UMSATZKENNUNG VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Umsatzkennung',
	NULLUMSATZ VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Umsatzmeldung mit Nullumsatz',
	UMSATZ_NETTO NUMBER(18,2) NOT NULL COMMENT 'Gemeldeter Nettoumsatz',
	UMSATZ_BRUTTO NUMBER(18,2) NOT NULL COMMENT 'Gemeldeter Bruttoumsatz',
	ERFASSER VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'Erfasser',
	DAT_ERSTERFASSUNG DATE NOT NULL COMMENT 'Datum der Ersterfassung',
	DAT_LETZTE_BEARBEITUNG DATE NOT NULL COMMENT 'Datum der letzten Bearbeitung',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_MIETVERTRAG_UMSATZVEREINBARUNG_PER primary key (MANDANT_ID, MV_INTRENO, MELDEREGEL, VERSION, KJMO, RHYTHMUS_ART)
)COMMENT='IMMO - Mietvertrag Umsatzvereinbarungen Mieter - SAP REFX - VISRREPORT'
;