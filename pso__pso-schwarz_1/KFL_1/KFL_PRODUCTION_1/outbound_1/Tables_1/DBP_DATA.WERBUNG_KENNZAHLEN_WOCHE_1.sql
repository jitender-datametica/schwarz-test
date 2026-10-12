--==============================================================
-- Table: werbung_kennzahlen_woche_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: werbung_kennzahlen_woche_1
   generated from Powerdesigner on Mittwoch, 24. April 2024 12:18:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.werbung_kennzahlen_woche_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
kjwo BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kalenderjahreswoche. Format JJJJWW. Fuer DE die Woche_1, in der die Werbung endet. Fuer KMO die Woche_1, in der die Werbung beginnt.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
werbe_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Typ der Werbung (Woche_1, Wochenanfang etc). Keine Lookup-Tabelle vorhanden.'),
menge_tag1 NUMERIC(9,3) DEFAULT 0 NOT NULL
OPTIONS(description='Abverkaufsmenge am ersten Tag_1 der Werbung / Total sales_1 volume of the 1st day of the promotion + the 1st day of every following week of the promotion.            For Promotions that last more than a week this is the total volume of sales_1 on 1st + 8th+15th day'),
menge_tag2 NUMERIC(9,3) DEFAULT 0 NOT NULL
OPTIONS(description='Abverkaufsmenge am zweiten Tag_1 der Werbung. / Total sales_1 volume of the 2nd day of the promotion + the 2nd day of every following week of the promotion.            For Promotions that last more than a week this is the total volume of sales_1 on 2nd + 9th+16th day'),
menge_tag3 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am dritten Tag_1 der Werbung. / Total sales_1 volume of the 3rd day of the promotion + the 3rd day of every following week of the promotion.            For Promotions that last more than a week this is the total volume of sales_1 on 3rd + 10th+17th day'),
menge_tag4 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am vierten Tag_1 der Werbung. / Total sales_1 volume of the 4th day of the promotion + the 4th day of every following week of the promotion.            For Promotions that last more than a week this is the total volume of sales_1 on 4th + 11th+18th day'),
menge_tag5 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am fuenften Tag_1 der Werbung. / Total sales_1 volume of the 5th day of the promotion + the 5th day of every following week of the promotion.            For Promotions that last more than a week this is the total volume of sales_1 on 5th + 12th+19th day'),
menge_tag6 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am sechsten Tag_1 der Werbung. / Total sales_1 volume of the 6th day of the promotion + the 6th day of every following week of the promotion.            For Promotions that last more than a week this is the total volume of sales_1 on 6th + 13th ... day'),
menge_tag7 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am siebten Tag_1 der Werbung. / Total sales_1 volume of the 7th day of the promotion + the 7th day of every following week of the promotion.            For Promotions that last more than a week this is the total volume of sales_1 on 7th + 14th...'),
menge_nur_tag1 NUMERIC(9,3)
OPTIONS(description='Abverkaufsmenge nur am ersten Tag_1 der Werbung / Total sales_1 volume ONLY of the 1st day of the promotion. If the promotion is longer than a week, this is still only the amount on the 1st day. (8th, and 15th day are NOT included)'),
tage_menge_0 BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl der Tage ohne Abverkauf.'),
menge_endbestand NUMERIC(18,3) NOT NULL OPTIONS(description='Bestandsmenge am Ende der Aktion.'),
menge_aktionsstart NUMERIC(18,3) NOT NULL OPTIONS(description='Bestandsmenge zum Beginn der Aktion.'),
umsatz_netto_tag1 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am ersten Tag_1 der Werbung.'),
umsatz_netto_tag2 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am zweiten Tag_1 der Werbung.'),
umsatz_netto_tag3 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am dritten Tag_1 der Werbung.'),
umsatz_netto_tag4 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am vierten Tag_1 der Werbung.'),
umsatz_netto_tag5 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am fuenften Tag_1 der Werbung.'),
umsatz_netto_tag6 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am sechsten Tag_1 der Werbung.'),
umsatz_netto_tag7 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am siebten Tag_1 der Werbung.'),
we_menge NUMERIC(18,3) NOT NULL OPTIONS(description='Wareneingang in der Werbewoche.'),
min_sicherh_bestand NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge, die unterste Grenze für den Sicherheitsbestand angibt. angereichert aus art_wup_status_per.'),
posten_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennzeichnung des Postenartikels, z.Bsp. PN. Redundant zu art_1, aufgrund Historisierung hier gespeichert.'),
we_menge_zentral NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Wareneingang in der Werbewoche und der Vorwoche, nur zentrale Bestellarten.'),
faktor_flaki NUMERIC(9,6) NOT NULL OPTIONS(description='Umrechnungsfaktor Flasche in Kiste.'),
mutter_wb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikelnummer des Mutter-Werbeartikels ist hier festgeschrieben. Bei Waisen ist die eigene Artikelnummer enthalten.'),
wtag_id_start BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Wochentag ID des Werbestarts, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag.'),
wtag_id_ende BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Wochentag ID des Werbeendes, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag.'),
menge_historie_af NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Durchschnittliche Abverkaufsmenge der letzten 6 aktionsfreien Wochen.'),
anzahl_nullbestand BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Tage mit Nullbestand waehrend des Aktionszeitraums.'),
anzahl_tage_aktion BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Anzahl Tage der Aktion.'),
menge_tag1_7bis13h NUMERIC(9,3) DEFAULT 0 NOT NULL
OPTIONS(description='Abverkaufsmenge am ersten Tag_1 der Werbung von 7 bis 13 Uhr.'),
lager_prozent BIGNUMERIC(38,0) DEFAULT 100 NOT NULL
OPTIONS(description='Lagerprozentsatz. Gibt an, wieviel Prozent der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel_1 vom Lager ausgeliefert wird (wird redundant aus der Tabelle art_1 geladen).'),
mhd_zeitraum BIGNUMERIC(38,0)
OPTIONS(description='Dieses Feld gibt den standardmaessigen Mindesthaltbarkeitszeitraum fuer diesen Artikel_1 in Tagen an (wird redundant aus der Tabelle art_1 geladen).'),
sollbestand NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Sollbestand (wird redundant aus der Tabelle art_wup_status_per_1 geladen).'),
menge_bestand_soll_max NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Maximaler Sollbestand (PRWOG) (wird redundant aus der Tabelle art_wup_nachschub_per_1 geladen).'),
werbenachvermarktung_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag: Nachvermarktung des Werbeartikel (Verlaengerung Werbezeitraum).'),
we_menge_vor_aktion NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Wareneingang vor Aktion.'),
art_mutter_bezugsweg_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Bezugsweg Werbemutter.'),
anzahl_nullbestand_tag1 BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am ersten Aktions-Wochentag fuer den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their first day)'),
anzahl_nullbestand_tag2 BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 2nd  Aktions-Wochentag fuer den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their second day)'),
anzahl_nullbestand_tag3 BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 3rd  Aktions-Wochentag fuer den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their third day)'),
anzahl_nullbestand_tag4 BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 4th  Aktions-Wochentag fuer den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their fourth  day)'),
anzahl_nullbestand_tag5 BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 5th  Aktions-Wochentag fuer den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their 5th  day)'),
anzahl_nullbestand_tag6 BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 6th  Aktions-Wochentag fuer den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their 6th day)'),
anzahl_nullbestand_tag7 BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 7th  Aktions-Wochentag fuer den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on 7th day)'),
anzahl_nullbestand_tag1bis3 BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestand in den ersten drei Aktion5th Aktionstag stagen fuer den Artikel_1 innerhalb der Kalenderwoche (kjwo).'),
anzahl_minusbestand BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Tage mit Minusbestand waehrend des Aktionszeitraums.'),
anzahl_minusbestand_tag1 BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Minusbestand am ersten Tag_1 des Aktionszeitraums.'),
anzahl_minusbestand_tag1bis3 BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Tage mit Minusbestand waehrend der ersten drei Tage des Aktionszeitraums.'),
avq_relevant_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Datensatz relevant fuer Abverkaufsquote, AVQ (normale Aktion_1  = 1, BBY + Kundenkarte = 0).'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
menge_sa NUMERIC(9,3) OPTIONS(description='Absatz Menge nur SA (Sonderaktion)'),
vk_vor_aktion_brutto NUMERIC(9,3) OPTIONS(description='Verkaufspreis Brutto vor Aktion_1'),
vk_aktion_brutto NUMERIC(9,3) OPTIONS(description='Verkaufspreis Brutto in Aktion_1'),
vk_kcard_brutto NUMERIC(9,3) OPTIONS(description='Verkaufspreis Brutto in Aktion_1 für K-CARD Inhaber'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kjwo, wup_id, nb_id, art_id, werbe_typ_id) NOT ENFORCED
) CLUSTER BY mandant_id, kjwo
OPTIONS(description='AIS - Aggregat ueber Aktionsartikel- Abverkauf und Bestand pro Woche. Nur Artikel_1, die speziellen Kriterien genuegen.');