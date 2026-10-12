create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.PREISINDEX_GESAMT_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	DAT_ERFASS DATE NOT NULL COMMENT 'Der Tag_1, an dem der Report ausgelöst wird. Nicht das Datum, an dem der Preis erfasst wurde, sondern das \""Freigabe\""-Datum, an dem diese Datenlieferung berechnet (in SAP) wurde.Tag_1 der Indexberechnung. ',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_UMSATZ_ART_GESAMT NUMBER(18,5) COMMENT 'Summe aller Artikel_1 letzte 12 Monate (abgeschlossen, ohne Gewichtung)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_PREISINDEX_GESAMT primary key (MANDANT_ID, DAT_ERFASS)
)COMMENT='Quelle: ZEKEWK100, berechnet werden Preisindizes (Verhältnis der KFL Preise zum Preis des vergleichbaren Artikels eines Konkurrenten). Die Berechnungen werden je Artikel_1 - Konkurrent - Land_1 zu einen Erfassdatum (Tag_1 der Berechnungen in SAP) freigegeben. Die Preise der Konkurrenten werden durch Markteinholer beschaffen. Ebene: Land_1, Erfassdatum'
;
