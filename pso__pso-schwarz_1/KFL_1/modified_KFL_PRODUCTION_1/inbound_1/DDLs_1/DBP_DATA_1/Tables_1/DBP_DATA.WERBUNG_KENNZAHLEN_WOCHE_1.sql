--==============================================================
-- Table: werbung_kennzahlen_woche_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: werbung_kennzahlen_woche_1
   generated from Powerdesigner on Mittwoch, 24. April 2024 12:18:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WERBUNG_KENNZAHLEN_WOCHE_1 CLUSTER BY (
     MANDANT_ID,
     KJWO 
)
 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   kjwo                                INTEGER     NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW. Fuer DE die Woche_1, in der die Werbung endet. Fuer KMO die Woche_1, in der die Werbung beginnt.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
   werbe_typ_id                        INTEGER     NOT NULL COMMENT 'Typ der Werbung (Woche_1, Wochenanfang etc). Keine Lookup-Tabelle vorhanden.',
   menge_tag1                          NUMBER(29,3)      NOT NULL DEFAULT 0 COMMENT 'Abverkaufsmenge am ersten Tag_1 der Werbung / Total sales_1 volume of the 1st day of the promotion + the 1st day of every following week of the promotion.
            For Promotions that last more than a week this is the total volume of sales_1 on 1st + 8th+15th day',
   menge_tag2                          NUMBER(29,3)      NOT NULL DEFAULT 0 COMMENT 'Abverkaufsmenge am zweiten Tag_1 der Werbung. / Total sales_1 volume of the 2nd day of the promotion + the 2nd day of every following week of the promotion.
            For Promotions that last more than a week this is the total volume of sales_1 on 2nd + 9th+16th day',
   menge_tag3                          NUMBER(29,3)      NOT NULL COMMENT 'Abverkaufsmenge am dritten Tag_1 der Werbung. / Total sales_1 volume of the 3rd day of the promotion + the 3rd day of every following week of the promotion.
            For Promotions that last more than a week this is the total volume of sales_1 on 3rd + 10th+17th day',
   menge_tag4                          NUMBER(29,3)      NOT NULL COMMENT 'Abverkaufsmenge am vierten Tag_1 der Werbung. / Total sales_1 volume of the 4th day of the promotion + the 4th day of every following week of the promotion.
            For Promotions that last more than a week this is the total volume of sales_1 on 4th + 11th+18th day',
   menge_tag5                          NUMBER(29,3)      NOT NULL COMMENT 'Abverkaufsmenge am fuenften Tag_1 der Werbung. / Total sales_1 volume of the 5th day of the promotion + the 5th day of every following week of the promotion.
            For Promotions that last more than a week this is the total volume of sales_1 on 5th + 12th+19th day',
   menge_tag6                          NUMBER(29,3)      NOT NULL COMMENT 'Abverkaufsmenge am sechsten Tag_1 der Werbung. / Total sales_1 volume of the 6th day of the promotion + the 6th day of every following week of the promotion.
            For Promotions that last more than a week this is the total volume of sales_1 on 6th + 13th ... day',
   menge_tag7                          NUMBER(29,3)      NOT NULL COMMENT 'Abverkaufsmenge am siebten Tag_1 der Werbung. / Total sales_1 volume of the 7th day of the promotion + the 7th day of every following week of the promotion.
            For Promotions that last more than a week this is the total volume of sales_1 on 7th + 14th...',
   menge_nur_tag1                      NUMBER(29,3)      COMMENT 'Abverkaufsmenge nur am ersten Tag_1 der Werbung / Total sales_1 volume ONLY of the 1st day of the promotion. If the promotion is longer than a week, this is still only the amount on the 1st day. (8th, and 15th day are NOT included)',
   tage_menge_0                        INTEGER     NOT NULL COMMENT 'Anzahl der Tage ohne Abverkauf.',
   menge_endbestand                    NUMBER(29,3)     NOT NULL COMMENT 'Bestandsmenge am Ende der Aktion.',
   menge_aktionsstart                  NUMBER(29,3)     NOT NULL COMMENT 'Bestandsmenge zum Beginn der Aktion.',
   umsatz_netto_tag1                   NUMBER(29,4)     NOT NULL COMMENT 'Nettoumsatz am ersten Tag_1 der Werbung.',
   umsatz_netto_tag2                   NUMBER(29,4)     NOT NULL COMMENT 'Nettoumsatz am zweiten Tag_1 der Werbung.',
   umsatz_netto_tag3                   NUMBER(29,4)     NOT NULL COMMENT 'Nettoumsatz am dritten Tag_1 der Werbung.',
   umsatz_netto_tag4                   NUMBER(29,4)     NOT NULL COMMENT 'Nettoumsatz am vierten Tag_1 der Werbung.',
   umsatz_netto_tag5                   NUMBER(29,4)     NOT NULL COMMENT 'Nettoumsatz am fuenften Tag_1 der Werbung.',
   umsatz_netto_tag6                   NUMBER(29,4)     NOT NULL COMMENT 'Nettoumsatz am sechsten Tag_1 der Werbung.',
   umsatz_netto_tag7                   NUMBER(29,4)     NOT NULL COMMENT 'Nettoumsatz am siebten Tag_1 der Werbung.',
   we_menge                            NUMBER(29,3)     NOT NULL COMMENT 'Wareneingang in der Werbewoche.',
   min_sicherh_bestand                 NUMBER(29,3)     NOT NULL COMMENT 'Menge, die unterste Grenze für den Sicherheitsbestand angibt. angereichert aus art_wup_status_per.',
   posten_id                           VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige Kennzeichnung des Postenartikels, z.Bsp. PN. Redundant zu art_1, aufgrund Historisierung hier gespeichert.',
   we_menge_zentral                    NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Wareneingang in der Werbewoche und der Vorwoche, nur zentrale Bestellarten.',
   faktor_flaki                        NUMBER(29,6)      NOT NULL COMMENT 'Umrechnungsfaktor Flasche in Kiste.',
   mutter_wb_id                        INTEGER     NOT NULL COMMENT 'Artikelnummer des Mutter-Werbeartikels ist hier festgeschrieben. Bei Waisen ist die eigene Artikelnummer enthalten.',
   wtag_id_start                       INTEGER     NOT NULL COMMENT 'Wochentag ID des Werbestarts, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag.',
   wtag_id_ende                        INTEGER     NOT NULL COMMENT 'Wochentag ID des Werbeendes, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag.',
   menge_historie_af                   NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Durchschnittliche Abverkaufsmenge der letzten 6 aktionsfreien Wochen.',
   anzahl_nullbestand                  INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl Tage mit Nullbestand waehrend des Aktionszeitraums.',
   anzahl_tage_aktion                  INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl Tage der Aktion.',
   menge_tag1_7bis13h                  NUMBER(29,3)      NOT NULL DEFAULT 0 COMMENT 'Abverkaufsmenge am ersten Tag_1 der Werbung von 7 bis 13 Uhr.',
   lager_prozent                       INTEGER     NOT NULL DEFAULT 100 COMMENT 'Lagerprozentsatz. Gibt an, wieviel Prozent der Restlaufzeit noch nicht abgelaufen sein darf, wenn der Artikel_1 vom Lager ausgeliefert wird (wird redundant aus der Tabelle art_1 geladen).',
   mhd_zeitraum                        INTEGER     COMMENT 'Dieses Feld gibt den standardmaessigen Mindesthaltbarkeitszeitraum fuer diesen Artikel_1 in Tagen an (wird redundant aus der Tabelle art_1 geladen).',
   sollbestand                         NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Sollbestand (wird redundant aus der Tabelle art_wup_status_per_1 geladen).',
   menge_bestand_soll_max              NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Maximaler Sollbestand (PRWOG) (wird redundant aus der Tabelle art_wup_nachschub_per_1 geladen).',
   werbenachvermarktung_fg             INTEGER     NOT NULL DEFAULT 0 COMMENT 'Flag: Nachvermarktung des Werbeartikel (Verlaengerung Werbezeitraum).',
   we_menge_vor_aktion                 NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Wareneingang vor Aktion.',
   art_mutter_bezugsweg_id             INTEGER     NOT NULL DEFAULT -1 COMMENT 'Bezugsweg Werbemutter.',
   anzahl_nullbestand_tag1             INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl Nullbestände am ersten Aktions-Wochentag fuer den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their first day)',
   anzahl_nullbestand_tag2             INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl Nullbestände am 2nd  Aktions-Wochentag fuer den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their second day)',
   anzahl_nullbestand_tag3             INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl Nullbestände am 3rd  Aktions-Wochentag fuer den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their third day)',
   anzahl_nullbestand_tag4             INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl Nullbestände am 4th  Aktions-Wochentag fuer den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their fourth  day)',
   anzahl_nullbestand_tag5             INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl Nullbestände am 5th  Aktions-Wochentag fuer den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their 5th  day)',
   anzahl_nullbestand_tag6             INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl Nullbestände am 6th  Aktions-Wochentag fuer den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on their 6th day)',
   anzahl_nullbestand_tag7             INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl Nullbestände am 7th  Aktions-Wochentag fuer den Artikel_1, bei Gültigkeit > 1 Woche_1 können Werte > 1 entstehen (how many weeks of the promotion had zero stock on 7th day)',
   anzahl_nullbestand_tag1bis3         INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl Nullbestand in den ersten drei Aktion5th Aktionstag stagen fuer den Artikel_1 innerhalb der Kalenderwoche (kjwo).',
   anzahl_minusbestand                 INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl Tage mit Minusbestand waehrend des Aktionszeitraums.',
   anzahl_minusbestand_tag1            INTEGER     NOT NULL DEFAULT 0 COMMENT 'Minusbestand am ersten Tag_1 des Aktionszeitraums.',
   anzahl_minusbestand_tag1bis3        INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl Tage mit Minusbestand waehrend der ersten drei Tage des Aktionszeitraums.',
   avq_relevant_fg                     INTEGER     COMMENT 'Flag: Datensatz relevant fuer Abverkaufsquote, AVQ (normale Aktion_1  = 1, BBY + Kundenkarte = 0).',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   menge_sa                            NUMBER(29,3)      COMMENT 'Absatz Menge nur SA (Sonderaktion)',
   vk_vor_aktion_brutto                NUMBER(29,3)      COMMENT 'Verkaufspreis Brutto vor Aktion_1',
   vk_aktion_brutto                    NUMBER(29,3)      COMMENT 'Verkaufspreis Brutto in Aktion_1',
   vk_kcard_brutto                     NUMBER(29,3)      COMMENT 'Verkaufspreis Brutto in Aktion_1 für K-CARD Inhaber',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WERBUNG_KENNZAHLEN_WOCHE PRIMARY KEY (mandant_id, kjwo, wup_id, nb_id, art_id, werbe_typ_id) NOT ENFORCED
)  COMMENT = 'AIS - Aggregat ueber Aktionsartikel- Abverkauf und Bestand pro Woche. Nur Artikel_1, die speziellen Kriterien genuegen.';
