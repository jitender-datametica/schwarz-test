CREATE OR REPLACE TABLE kfl_production_dbp_data.preisindex_kukla_art_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
dat_erfass DATE NOT NULL
OPTIONS(description='Der Tag_1, an dem der Report ausgelöst wird. Nicht das Datum, an dem der Preis erfasst wurde, sondern das\""Freigabe\""-Datum, an dem diese Datenlieferung berechnet (in SAP) wurde.Tag_1 der Indexberechnung. '),
kukla_id STRING(2) NOT NULL OPTIONS(description='ID des Konkurrenten (z.B. 05 für Aldi Nord)'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
dat_gueltig_von DATE
OPTIONS(description='Preiseinholungen finden in verschiedenen Rhythmen statt. Zeitraum in dem die Preise gezogen werden. Wenn man Preise im Oktober will dann wird z.B. gefiltert auf 01.10. und 31.10; also Eingangsdatum für die Preisinfo. '),
dat_gueltig_bis DATE
OPTIONS(description='Preiseinholungen finden in verschiedenen Rhythmen statt. Zeitraum in dem die Preise gezogen werden. Wenn man Preise im Oktober will dann wird z.B. gefiltert auf 01.10. und 31.10; also Eingangsdatum für die Preisinfo. Preis ist immer gültig bis der nächste kommt. Kann je nach Land_1 und Artikelart eine_1 Spanne von bis zu 3 oder 4 Monaten ergeben.'),
dat_vorkalk DATE
OPTIONS(description='Standdatum von KFL Preisen. Früher hat man Preise eingeholt, z.B. Montag, dann wurde ein Index gebildet, dann wurde kalkuliert, dann wurden neue Preise eingeholt und nochmal kalkuliert. Es werden zwei Indizes gebildet. Standdatum vor Kalkulatiuon und Standdatum nach Kalkulation. KL Preis Vorkalkuation: zeigt von wann der KL Preis ist.'),
dat_nachkalk DATE
OPTIONS(description='KL Preis Vorkalkuation: zeigt von wann der KL Preis ist. Unterschied: Zwischendurch wurde was berechnet. Kann gleiches Datum wie Vorkalkulation sein. '),
rate_kukla_art_ungewichtet_vorkalk BIGNUMERIC(38,22)
OPTIONS(description='z.B. Bananenpreis / Bananenpreis Kaufland (Vorkalk)'),
rate_kukla_art_ungewichtet_nachkalk BIGNUMERIC(38,22)
OPTIONS(description='z.B. Bananenpreis / Bananenpreis Kaufland (Nachkalk)'),
rate_kukla_art_gewichtet_vorkalk BIGNUMERIC(38,22) OPTIONS(description='Index inkl. Gewichtung (Vorkalk)'),
rate_kukla_art_gewichtet_nachkalk BIGNUMERIC(38,22) OPTIONS(description='Index inkl. Gewichtung (Nachkalk)'),
preis_kukla_art_durchschnitt NUMERIC(29,5)
OPTIONS(description='Preise werden auf Kundenklassenebene gezogen. Preise werden bei 20 Lidls eingeholt, z.B. für Bananen. Von jedem der 20 Lidls wird der neueste Preis genommen und dann davon der Durchschnitt gezogen. '),
preis_kukla_art_gewichtet BIGNUMERIC(38,22)
OPTIONS(description='Zwischenberechnung Gewichtungsfaktor * Mitbewerberpreis'),
proz_schwellenwert NUMERIC(29,5)
OPTIONS(description='Information zur Transparenz: Wettbewerbspreise können teils stark abweichen zu unseren Preisen. In den internen Berechnungen werden Schwellwerte integriert um Datenqualität zu verbessern, falls sich Preiseinholer vertan haben. Zeigt also, bis wie viel Abweichung die Berechnungen einbezogen werden.'),
betrag_umsatz_art NUMERIC(29,5)
OPTIONS(description='Bereinigter AF Umsatz (Umsatz Artikel_1 wird durch die Anzahl der Monate, in denen der Artikel_1 Verkauf hatte, geteilt) für den Artikel_1 der letzten 12 Monate (abgeschlossen)'),
faktor_gewichtung_umsatz BIGNUMERIC(38,22) OPTIONS(description='Artikelumsatz geteilt durch den KFL Gesamtumsatz'),
preis_art_gewichtet_vorkalk BIGNUMERIC(38,22)
OPTIONS(description='Zwischenberechnung Gewichtungsfaktor * KFL Preis (Vorkalk)'),
preis_art_gewichtet_nachkalk BIGNUMERIC(38,22)
OPTIONS(description='Zwischenberechnung Gewichtungsfaktor * KFL Preis (Nachkalk)'),
preis_art_vorkalk NUMERIC(29,5)
OPTIONS(description='KL Preis vor erster Indexberechnung, zu Standdatum Vorkalkulation.'),
preis_art_nachkalk NUMERIC(29,5) OPTIONS(description='Zweite Berechnung. Siehe Vorkalk, kann abweichen'),
mkw_cd STRING(1)
OPTIONS(description='Kennzeichen zur Mutter-Kind-Beziehung des Artikels zum Zeitpunkt des Erfassdatums'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat_erfass, kukla_id, art_id) NOT ENFORCED
)
OPTIONS(description='Quelle: ZEKEWK100, berechnet werden Preisindizes (Verhältnis der KFL Preise zum Preis des vergleichbaren Artikels eines Konkurrenten). Die Berechnungen werden je Artikel_1 - Konkurrent - Land_1 zu einen Erfassdatum (Tag_1 der Berechnungen in SAP) freigegeben. Die Preise der Konkurrenten werden durch Markteinholer beschaffen. Ebene: Land_1, Erfassdatum, Kundenklassifikation, Artikel_1');