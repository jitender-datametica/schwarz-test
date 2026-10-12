DROP TABLE IF EXISTS kfl_production_dbp_data.werbung_kennzahlen_woche;
CREATE OR REPLACE TABLE kfl_production_dbp_data.werbung_kennzahlen_woche (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
kjwo INTEGER NOT NULL
OPTIONS(description='Kalenderjahreswoche. Format JJJJWW. Fuer DE die Woche, in der die Werbung endet. Fuer KMO die Woche, in der die Werbung beginnt.'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
werbe_typ_id INTEGER NOT NULL
OPTIONS(description='Typ der Werbung (Woche, Wochenanfang etc). Keine Lookup-Tabelle vorhanden.'),
menge_tag1 NUMERIC(9,3) DEFAULT 0 NOT NULL
OPTIONS(description='Abverkaufsmenge am ersten Tag der Werbung / Total sales volume of the 1st day of the promotion + the 1st day of every following week of the promotion.\n            For Promotions that last more than a week this is the total volume of sales on 1st + 8th+15th day'),
menge_tag2 NUMERIC(9,3) DEFAULT 0 NOT NULL
OPTIONS(description='Abverkaufsmenge am zweiten Tag der Werbung. / Total sales volume of the 2nd day of the promotion + the 2nd day of every following week of the promotion.\n            For Promotions that last more than a week this is the total volume of sales on 2nd + 9th+16th day'),
menge_tag3 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am dritten Tag der Werbung. / Total sales volume of the 3rd day of the promotion + the 3rd day of every following week of the promotion.\n            For Promotions that last more than a week this is the total volume of sales on 3rd + 10th+17th day'),
menge_tag4 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am vierten Tag der Werbung. / Total sales volume of the 4th day of the promotion + the 4th day of every following week of the promotion.\n            For Promotions that last more than a week this is the total volume of sales on 4th + 11th+18th day'),
menge_tag5 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am fuenften Tag der Werbung. / Total sales volume of the 5th day of the promotion + the 5th day of every following week of the promotion.\n            For Promotions that last more than a week this is the total volume of sales on 5th + 12th+19th day'),
menge_tag6 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am sechsten Tag der Werbung. / Total sales volume of the 6th day of the promotion + the 6th day of every following week of the promotion.\n            For Promotions that last more than a week this is the total volume of sales on 6th + 13th ... day'),
menge_tag7 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am siebten Tag der Werbung. / Total sales volume of the 7th day of the promotion + the 7th day of every following week of the promotion.\n            For Promotions that last more than a week this is the total volume of sales on 7th + 14th...'),
menge_nur_tag1 NUMERIC(9,3)
OPTIONS(description='Abverkaufsmenge nur am ersten Tag der Werbung / Total sales volume ONLY of the 1st day of the promotion. If the promotion is longer than a week, this is still only the amount on the 1st day. (8th, and 15th day are NOT included)'),
tage_menge_0 INTEGER NOT NULL OPTIONS(description='Anzahl der Tage ohne Abverkauf.'),
menge_endbestand NUMERIC(18,3) NOT NULL OPTIONS(description='Bestandsmenge am Ende der Aktion.'),
menge_aktionsstart NUMERIC(18,3) NOT NULL OPTIONS(description='Bestandsmenge zum Beginn der Aktion.'),
umsatz_netto_tag1 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am ersten Tag der Werbung.'),
umsatz_netto_tag2 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am zweiten Tag der Werbung.'),
umsatz_netto_tag3 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am dritten Tag der Werbung.'),
umsatz_netto_tag4 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am vierten Tag der Werbung.'),
umsatz_netto_tag5 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am fuenften Tag der Werbung.'),
umsatz_netto_tag6 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am sechsten Tag der Werbung.'),
umsatz_netto_tag7 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am siebten Tag der Werbung.'),
we_menge NUMERIC(18,3) NOT NULL OPTIONS(description='Wareneingang in der Werbewoche.'),
min_sicherh_bestand NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge, die unterste Grenze für den Sicherheitsbestand angibt. angereichert aus art_wup_status_per.'),
posten_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennzeichnung des Postenartikels, z.Bsp. PN. Redundant zu art, aufgrund Historisierung hier gespeichert.'),
we_menge_zentral NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Wareneingang in der Werbewoche und der Vorwoche, nur zentrale Bestellarten.'),
faktor_flaki NUMERIC(9,6) NOT NULL OPTIONS(description='Umrechnungsfaktor Flasche in Kiste.'),
mutter_wb_id INTEGER NOT NULL
OPTIONS(description='Artikelnummer des Mutter-Werbeartikels ist hier festgeschrieben. Bei Waisen ist die eigene Artikelnummer enthalten.'),
wtag_id_start INTEGER NOT NULL
OPTIONS(description='Wochentag ID des Werbestarts, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag.'),
wtag_id_ende INTEGER NOT NULL
OPTIONS(description='Wochentag ID des Werbeendes, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag.'),
menge_historie_af NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Durchschnittliche Abverkaufsmenge der letzten 6 aktionsfreien Wochen.'),
anzahl_nullbestand INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Tage mit Nullbestand waehrend des Aktionszeitraums.'),
anzahl_tage_aktion INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Anzahl Tage der Aktion.'),
menge_tag1_7bis13h NUMERIC(9,3) DEFAULT 0 NOT NULL
OPTIONS(description='Abverkaufsmenge am ersten Tag der Werbung von 7 bis 13 Uhr.'),
lager_prozent INTEGER DEFAULT 100 NOT NULL
OPTIONS(description='Lagerprozentsatz. Gibt an, wieviel Prozent der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel vom Lager ausgeliefert wird (wird redundant aus der Tabelle art geladen).'),
mhd_zeitraum INTEGER
OPTIONS(description='Dieses Feld gibt den standardmaessigen Mindesthaltbarkeitszeitraum fuer diesen Artikel in Tagen an (wird redundant aus der Tabelle art geladen).'),
sollbestand NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Sollbestand (wird redundant aus der Tabelle art_wup_status_per geladen).'),
menge_bestand_soll_max NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Maximaler Sollbestand (PRWOG) (wird redundant aus der Tabelle art_wup_nachschub_per geladen).'),
werbenachvermarktung_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag: Nachvermarktung des Werbeartikel (Verlaengerung Werbezeitraum).'),
we_menge_vor_aktion NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Wareneingang vor Aktion.'),
art_mutter_bezugsweg_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Bezugsweg Werbemutter.'),
anzahl_nullbestand_tag1 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am ersten Aktions-Wochentag fuer den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their first day)'),
anzahl_nullbestand_tag2 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 2nd  Aktions-Wochentag fuer den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their second day)'),
anzahl_nullbestand_tag3 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 3rd  Aktions-Wochentag fuer den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their third day)'),
anzahl_nullbestand_tag4 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 4th  Aktions-Wochentag fuer den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their fourth  day)'),
anzahl_nullbestand_tag5 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 5th  Aktions-Wochentag fuer den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their 5th  day)'),
anzahl_nullbestand_tag6 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 6th  Aktions-Wochentag fuer den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their 6th day)'),
anzahl_nullbestand_tag7 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 7th  Aktions-Wochentag fuer den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on 7th day)'),
anzahl_nullbestand_tag1bis3 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestand in den ersten drei Aktion5th Aktionstag stagen fuer den Artikel innerhalb der Kalenderwoche (kjwo).'),
anzahl_minusbestand INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Tage mit Minusbestand waehrend des Aktionszeitraums.'),
anzahl_minusbestand_tag1 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Minusbestand am ersten Tag des Aktionszeitraums.'),
anzahl_minusbestand_tag1bis3 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Tage mit Minusbestand waehrend der ersten drei Tage des Aktionszeitraums.'),
avq_relevant_fg INTEGER
OPTIONS(description='Flag: Datensatz relevant fuer Abverkaufsquote, AVQ (normale Aktion  = 1, BBY + Kundenkarte = 0).'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
menge_sa NUMERIC(9,3) OPTIONS(description='Absatz Menge nur SA (Sonderaktion)'),
vk_vor_aktion_brutto NUMERIC(9,3) OPTIONS(description='Verkaufspreis Brutto vor Aktion'),
vk_aktion_brutto NUMERIC(9,3) OPTIONS(description='Verkaufspreis Brutto in Aktion'),
vk_kcard_brutto NUMERIC(9,3) OPTIONS(description='Verkaufspreis Brutto in Aktion für K-CARD Inhaber'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kjwo, wup_id, nb_id, art_id, werbe_typ_id) NOT ENFORCED
) CLUSTER BY mandant_id, kjwo
OPTIONS(description='AIS - Aggregat ueber Aktionsartikel- Abverkauf und Bestand pro Woche. Nur Artikel, die speziellen Kriterien genuegen.');