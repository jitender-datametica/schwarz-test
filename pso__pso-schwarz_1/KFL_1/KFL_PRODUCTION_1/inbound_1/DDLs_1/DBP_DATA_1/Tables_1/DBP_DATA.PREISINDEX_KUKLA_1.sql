create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.PREISINDEX_KUKLA_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	DAT_ERFASS DATE NOT NULL COMMENT 'Der Tag_1, an dem der Report ausgelöst wird. Nicht das Datum, an dem der Preis erfasst wurde, sondern das \""Freigabe\""-Datum, an dem diese Datenlieferung berechnet (in SAP) wurde.Tag_1 der Indexberechnung. ',
	KUKLA_ID VARCHAR(2) NOT NULL COMMENT 'ID des Konkurrenten (z.B. 05 für Aldi Nord)',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	ANZ_ART_VORKALK NUMBER(18,0) COMMENT 'Wie viele Artikel_1 wurden in die Index Kalkulation mit eingezogen. Es werden auf der \""KFL Artikel_1 Ebene\"" die Konkurrent-Gesamtsortiment-Infos mitangegeben. ',
	ANZ_ART_NACHKALK NUMBER(18,0) COMMENT 'Wie viele Artikel_1 wurden in die Index Kalkulation mit eingezogen. Es werden auf der \""KFL Artikel_1 Ebene\"" die Konkurrent-Gesamtsortiment-Infos mitangegeben.',
	BETRAG_VKP_VORKALK NUMBER(18,5) COMMENT 'Für jeden der eingeholten Konkurrent-Artikel_1 gibt es einen gematchten KFL Artikel. Hier wird die Summe der KFL Artikel_1 VKs gezeigt für alle Artikel_1, die mit einem Wettbewerber-Artikel_1 gematcht wurden.',
	BETRAG_VKP_NACHKALK NUMBER(18,5) COMMENT 'Für jeden der eingeholten Konkurrent-Artikel_1 gibt es einen gematchten KFL Artikel. Hier wird die Summe der KFL Artikel_1 VKs gezeigt für alle Artikel_1, die mit einem Wettbewerber-Artikel_1 gematcht wurden.',
	RATE_KUKLA_UNGEWICHTET_VORKALK NUMBER(38,22) COMMENT 'Index ungewichtet (ohne irgendwelche KPIs oder Metriken zu berücksichtigen) auf der Ebene KFL vs. Konkurrent. Über alle Artikel_1 gleich. Wichtig für den Vergleich zum Artikel. Aus Index und VKPreis Summe KFL lässt sich die Summe VK_1 Konkurrent errechnen.',
	RATE_KUKLA_UNGEWICHTET_NACHKALK NUMBER(38,22) COMMENT 'Index ungewichtet (ohne irgendwelche KPIs oder Metriken zu berücksichtigen) auf der Ebene KFL vs. Konkurrent. Über alle Artikel_1 gleich. Wichtig für den Vergleich zum Artikel. Aus Index und VKPreis Summe KFL lässt sich die Summe VK_1 Konkurrent errechnen.',
	RATE_KUKLA_GEWICHTET_VORKALK NUMBER(38,22) COMMENT 'Beim gewichteten Index werden die Umsätze der Artikel_1 miteinberechnet',
	RATE_KUKLA_GEWICHTET_NACHKALK NUMBER(38,22) COMMENT 'Beim gewichteten Index werden die Umsätze der Artikel_1 miteinberechnet',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_PREISINDEX_KUKLA primary key (MANDANT_ID, KUKLA_ID, DAT_ERFASS)
)COMMENT='Quelle: ZEKEWK100, berechnet werden Preisindizes (Verhältnis der KFL Preise zum Preis des vergleichbaren Artikels eines Konkurrenten). Die Berechnungen werden je Artikel_1 - Konkurrent - Land_1 zu einen Erfassdatum (Tag_1 der Berechnungen in SAP) freigegeben. Die Preise der Konkurrenten werden durch Markteinholer beschaffen. Ebene: Land_1, Erfassdatum, Kundenklassifikation'
;
