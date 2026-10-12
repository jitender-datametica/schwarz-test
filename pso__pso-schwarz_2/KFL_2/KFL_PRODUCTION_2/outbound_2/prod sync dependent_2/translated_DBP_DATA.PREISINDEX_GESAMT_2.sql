CREATE OR REPLACE TABLE kfl_production_dbp_data.preisindex_gesamt_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
dat_erfass DATE NOT NULL
OPTIONS(description='Der Tag_2, an dem der Report ausgelöst wird. Nicht das Datum, an dem der Preis erfasst wurde, sondern das\""Freigabe\""-Datum, an dem diese Datenlieferung berechnet (in SAP) wurde.Tag_2 der Indexberechnung. '),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_umsatz_art_gesamt NUMERIC(29,5)
OPTIONS(description='Summe aller Artikel_2 letzte 12 Monate (abgeschlossen, ohne Gewichtung)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat_erfass) NOT ENFORCED
)
OPTIONS(description='Quelle: ZEKEWK100, berechnet werden Preisindizes (Verhältnis der KFL Preise zum Preis des vergleichbaren Artikels eines Konkurrenten). Die Berechnungen werden je Artikel_2 - Konkurrent - Land_2 zu einen Erfassdatum (Tag_2 der Berechnungen in SAP) freigegeben. Die Preise der Konkurrenten werden durch Markteinholer beschaffen. Ebene: Land_2, Erfassdatum');