DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.WERBUNG_KENNZAHLEN_WOCHE;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.WERBUNG_KENNZAHLEN_WOCHE (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
KJWO INTEGER NOT NULL
OPTIONS(description='Kalenderjahreswoche. Format JJJJWW. Fuer DE die Woche, in der die Werbung endet. Fuer KMO die Woche, in der die Werbung beginnt.'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
WERBE_TYP_ID INTEGER NOT NULL
OPTIONS(description='Typ der Werbung (Woche, Wochenanfang etc). Keine Lookup-Tabelle vorhanden.'),
MENGE_TAG1 NUMERIC(9,3) DEFAULT 0 NOT NULL
OPTIONS(description='Abverkaufsmenge am ersten Tag der Werbung / Total sales volume of the 1st day of the promotion + the 1st day of every following week of the promotion.\n            For Promotions that last more than a week this is the total volume of sales on 1st + 8th+15th day'),
MENGE_TAG2 NUMERIC(9,3) DEFAULT 0 NOT NULL
OPTIONS(description='Abverkaufsmenge am zweiten Tag der Werbung. / Total sales volume of the 2nd day of the promotion + the 2nd day of every following week of the promotion.\n            For Promotions that last more than a week this is the total volume of sales on 2nd + 9th+16th day'),
MENGE_TAG3 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am dritten Tag der Werbung. / Total sales volume of the 3rd day of the promotion + the 3rd day of every following week of the promotion.\n            For Promotions that last more than a week this is the total volume of sales on 3rd + 10th+17th day'),
MENGE_TAG4 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am vierten Tag der Werbung. / Total sales volume of the 4th day of the promotion + the 4th day of every following week of the promotion.\n            For Promotions that last more than a week this is the total volume of sales on 4th + 11th+18th day'),
MENGE_TAG5 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am fuenften Tag der Werbung. / Total sales volume of the 5th day of the promotion + the 5th day of every following week of the promotion.\n            For Promotions that last more than a week this is the total volume of sales on 5th + 12th+19th day'),
MENGE_TAG6 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am sechsten Tag der Werbung. / Total sales volume of the 6th day of the promotion + the 6th day of every following week of the promotion.\n            For Promotions that last more than a week this is the total volume of sales on 6th + 13th ... day'),
MENGE_TAG7 NUMERIC(9,3) NOT NULL
OPTIONS(description='Abverkaufsmenge am siebten Tag der Werbung. / Total sales volume of the 7th day of the promotion + the 7th day of every following week of the promotion.\n            For Promotions that last more than a week this is the total volume of sales on 7th + 14th...'),
MENGE_NUR_TAG1 NUMERIC(9,3)
OPTIONS(description='Abverkaufsmenge nur am ersten Tag der Werbung / Total sales volume ONLY of the 1st day of the promotion. If the promotion is longer than a week, this is still only the amount on the 1st day. (8th, and 15th day are NOT included)'),
TAGE_MENGE_0 INTEGER NOT NULL OPTIONS(description='Anzahl der Tage ohne Abverkauf.'),
MENGE_ENDBESTAND NUMERIC(18,3) NOT NULL OPTIONS(description='Bestandsmenge am Ende der Aktion.'),
MENGE_AKTIONSSTART NUMERIC(18,3) NOT NULL OPTIONS(description='Bestandsmenge zum Beginn der Aktion.'),
UMSATZ_NETTO_TAG1 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am ersten Tag der Werbung.'),
UMSATZ_NETTO_TAG2 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am zweiten Tag der Werbung.'),
UMSATZ_NETTO_TAG3 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am dritten Tag der Werbung.'),
UMSATZ_NETTO_TAG4 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am vierten Tag der Werbung.'),
UMSATZ_NETTO_TAG5 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am fuenften Tag der Werbung.'),
UMSATZ_NETTO_TAG6 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am sechsten Tag der Werbung.'),
UMSATZ_NETTO_TAG7 NUMERIC(18,4) NOT NULL OPTIONS(description='Nettoumsatz am siebten Tag der Werbung.'),
WE_MENGE NUMERIC(18,3) NOT NULL OPTIONS(description='Wareneingang in der Werbewoche.'),
MIN_SICHERH_BESTAND NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge, die unterste Grenze für den Sicherheitsbestand angibt. angereichert aus art_wup_status_per.'),
POSTEN_ID STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennzeichnung des Postenartikels, z.Bsp. PN. Redundant zu art, aufgrund Historisierung hier gespeichert.'),
WE_MENGE_ZENTRAL NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Wareneingang in der Werbewoche und der Vorwoche, nur zentrale Bestellarten.'),
FAKTOR_FLAKI NUMERIC(9,6) NOT NULL OPTIONS(description='Umrechnungsfaktor Flasche in Kiste.'),
MUTTER_WB_ID INTEGER NOT NULL
OPTIONS(description='Artikelnummer des Mutter-Werbeartikels ist hier festgeschrieben. Bei Waisen ist die eigene Artikelnummer enthalten.'),
WTAG_ID_START INTEGER NOT NULL
OPTIONS(description='Wochentag ID des Werbestarts, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag.'),
WTAG_ID_ENDE INTEGER NOT NULL
OPTIONS(description='Wochentag ID des Werbeendes, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag.'),
MENGE_HISTORIE_AF NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Durchschnittliche Abverkaufsmenge der letzten 6 aktionsfreien Wochen.'),
ANZAHL_NULLBESTAND INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Tage mit Nullbestand waehrend des Aktionszeitraums.'),
ANZAHL_TAGE_AKTION INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Anzahl Tage der Aktion.'),
MENGE_TAG1_7BIS13H NUMERIC(9,3) DEFAULT 0 NOT NULL
OPTIONS(description='Abverkaufsmenge am ersten Tag der Werbung von 7 bis 13 Uhr.'),
LAGER_PROZENT INTEGER DEFAULT 100 NOT NULL
OPTIONS(description='Lagerprozentsatz. Gibt an, wieviel Prozent der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel vom Lager ausgeliefert wird (wird redundant aus der Tabelle art geladen).'),
MHD_ZEITRAUM INTEGER
OPTIONS(description='Dieses Feld gibt den standardmaessigen Mindesthaltbarkeitszeitraum fuer diesen Artikel in Tagen an (wird redundant aus der Tabelle art geladen).'),
SOLLBESTAND NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Sollbestand (wird redundant aus der Tabelle art_wup_status_per geladen).'),
MENGE_BESTAND_SOLL_MAX NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Maximaler Sollbestand (PRWOG) (wird redundant aus der Tabelle art_wup_nachschub_per geladen).'),
WERBENACHVERMARKTUNG_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag: Nachvermarktung des Werbeartikel (Verlaengerung Werbezeitraum).'),
WE_MENGE_VOR_AKTION NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Wareneingang vor Aktion.'),
ART_MUTTER_BEZUGSWEG_ID INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Bezugsweg Werbemutter.'),
ANZAHL_NULLBESTAND_TAG1 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am ersten Aktions-Wochentag fuer den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their first day)'),
ANZAHL_NULLBESTAND_TAG2 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 2nd  Aktions-Wochentag fuer den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their second day)'),
ANZAHL_NULLBESTAND_TAG3 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 3rd  Aktions-Wochentag fuer den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their third day)'),
ANZAHL_NULLBESTAND_TAG4 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 4th  Aktions-Wochentag fuer den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their fourth  day)'),
ANZAHL_NULLBESTAND_TAG5 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 5th  Aktions-Wochentag fuer den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their 5th  day)'),
ANZAHL_NULLBESTAND_TAG6 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 6th  Aktions-Wochentag fuer den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their 6th day)'),
ANZAHL_NULLBESTAND_TAG7 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestände am 7th  Aktions-Wochentag fuer den Artikel, bei Gültigkeit > 1 Woche können Werte > 1 entstehen (how many weeks of the promotion had zero stock on 7th day)'),
ANZAHL_NULLBESTAND_TAG1BIS3 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Nullbestand in den ersten drei Aktion5th Aktionstag stagen fuer den Artikel innerhalb der Kalenderwoche (kjwo).'),
ANZAHL_MINUSBESTAND INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Tage mit Minusbestand waehrend des Aktionszeitraums.'),
ANZAHL_MINUSBESTAND_TAG1 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Minusbestand am ersten Tag des Aktionszeitraums.'),
ANZAHL_MINUSBESTAND_TAG1BIS3 INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Tage mit Minusbestand waehrend der ersten drei Tage des Aktionszeitraums.'),
AVQ_RELEVANT_FG INTEGER
OPTIONS(description='Flag: Datensatz relevant fuer Abverkaufsquote, AVQ (normale Aktion  = 1, BBY + Kundenkarte = 0).'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
MENGE_SA NUMERIC(9,3) OPTIONS(description='Absatz Menge nur SA (Sonderaktion)'),
VK_VOR_AKTION_BRUTTO NUMERIC(9,3) OPTIONS(description='Verkaufspreis Brutto vor Aktion'),
VK_AKTION_BRUTTO NUMERIC(9,3) OPTIONS(description='Verkaufspreis Brutto in Aktion'),
VK_KCARD_BRUTTO NUMERIC(9,3) OPTIONS(description='Verkaufspreis Brutto in Aktion für K-CARD Inhaber'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, KJWO, WUP_ID, NB_ID, ART_ID, WERBE_TYP_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID, KJWO
OPTIONS(description='AIS - Aggregat ueber Aktionsartikel- Abverkauf und Bestand pro Woche. Nur Artikel, die speziellen Kriterien genuegen.');