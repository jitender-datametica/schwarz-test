CREATE OR REPLACE TABLE kfl_production_dbp_data.preisindex_kukla_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
dat_erfass DATE NOT NULL
OPTIONS(description='Der Tag_2, an dem der Report ausgelöst wird. Nicht das Datum, an dem der Preis erfasst wurde, sondern das\""Freigabe\""-Datum, an dem diese Datenlieferung berechnet (in SAP) wurde.Tag_2 der Indexberechnung. '),
kukla_id STRING(2) NOT NULL OPTIONS(description='ID des Konkurrenten (z.B. 05 für Aldi Nord)'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
anz_art_vorkalk INTEGER
OPTIONS(description='Wie viele Artikel_2 wurden in die Index Kalkulation mit eingezogen. Es werden auf der\""KFL Artikel_2 Ebene\"" die Konkurrent-Gesamtsortiment-Infos mitangegeben. '),
anz_art_nachkalk INTEGER
OPTIONS(description='Wie viele Artikel_2 wurden in die Index Kalkulation mit eingezogen. Es werden auf der\""KFL Artikel_2 Ebene\"" die Konkurrent-Gesamtsortiment-Infos mitangegeben.'),
betrag_vkp_vorkalk NUMERIC(29,5)
OPTIONS(description='Für jeden der eingeholten Konkurrent-Artikel_2 gibt es einen gematchten KFL Artikel. Hier wird die Summe der KFL Artikel_2 VKs gezeigt für alle Artikel_2, die mit einem Wettbewerber-Artikel_2 gematcht wurden.'),
betrag_vkp_nachkalk NUMERIC(29,5)
OPTIONS(description='Für jeden der eingeholten Konkurrent-Artikel_2 gibt es einen gematchten KFL Artikel. Hier wird die Summe der KFL Artikel_2 VKs gezeigt für alle Artikel_2, die mit einem Wettbewerber-Artikel_2 gematcht wurden.'),
rate_kukla_ungewichtet_vorkalk BIGNUMERIC(38,22)
OPTIONS(description='Index ungewichtet (ohne irgendwelche KPIs oder Metriken zu berücksichtigen) auf der Ebene KFL vs. Konkurrent. Über alle Artikel_2 gleich. Wichtig für den Vergleich zum Artikel. Aus Index und VKPreis Summe KFL lässt sich die Summe VK_2 Konkurrent errechnen.'),
rate_kukla_ungewichtet_nachkalk BIGNUMERIC(38,22)
OPTIONS(description='Index ungewichtet (ohne irgendwelche KPIs oder Metriken zu berücksichtigen) auf der Ebene KFL vs. Konkurrent. Über alle Artikel_2 gleich. Wichtig für den Vergleich zum Artikel. Aus Index und VKPreis Summe KFL lässt sich die Summe VK_2 Konkurrent errechnen.'),
rate_kukla_gewichtet_vorkalk BIGNUMERIC(38,22)
OPTIONS(description='Beim gewichteten Index werden die Umsätze der Artikel_2 miteinberechnet'),
rate_kukla_gewichtet_nachkalk BIGNUMERIC(38,22)
OPTIONS(description='Beim gewichteten Index werden die Umsätze der Artikel_2 miteinberechnet'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kukla_id, dat_erfass) NOT ENFORCED
)
OPTIONS(description='Quelle: ZEKEWK100, berechnet werden Preisindizes (Verhältnis der KFL Preise zum Preis des vergleichbaren Artikels eines Konkurrenten). Die Berechnungen werden je Artikel_2 - Konkurrent - Land_2 zu einen Erfassdatum (Tag_2 der Berechnungen in SAP) freigegeben. Die Preise der Konkurrenten werden durch Markteinholer beschaffen. Ebene: Land_2, Erfassdatum, Kundenklassifikation');