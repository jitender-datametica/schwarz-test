--==============================================================
-- Table: rekl
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rekl
   generated from Powerdesigner on Montag, 12. August 2024 18:40:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rekl (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warenumschlagsplatz, an dem die Reklamation erfasst wurde'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
dat DATE NOT NULL OPTIONS(description='Datum des Reklamationsvorgangs.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikelnummer im DWH. Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
kasse_nr BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Nummer der Kasse - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.'),
bon_nr BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Nummer des Kassenbons - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.'),
pos_nr BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Position auf dem Kassenbon - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.'),
reklamationsgrund_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Reklamationskennzeichen, z.Bsp. 30.'),
ean_kasse BIGNUMERIC(38,0)
OPTIONS(description='Die EAN des Artikels.            Ein Kauflandartikel im System existiert unter einer Artikelnummer, welche mehrere GTINs zugeordnet haben kann. Beispiel: Alle Ravensburger Puzzle laufen unter einer einzigen Artikelnummer in SAP, da einfach nur allgemein "Puzzle" eingekauft wird und der Lieferant selbst entscheidet welche verschiedenen Arten er bereitstellt. Jede Puzzleart hat eine eigene GTIN, aber läuft in SAP unter einer gemeinsamen Nummer (Haupt-GTIN). Die genaue GTIN (EAN) des betrachteten Artikels lässt sich deshalb nur an der Kasse genau zuordnen.'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
vk_brutto_re BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Reklamierter Verkaufspreis pro Mengeneinheit.'),
vk_menge_re BIGNUMERIC(38,3) NOT NULL OPTIONS(description='Menge des reklamierten Artikels.'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Hauptlieferant (Kreditor), 6-stellige Lieferantennummer.'),
mhd STRING(6) COLLATE 'und:ci'
OPTIONS(description='Mindesthaltbarkeitsdatum, kommt in verschiedenen Formaten: TTMMJJ oder MMJJ oder JJ.'),
los_charge STRING(20) COLLATE 'und:ci'
OPTIONS(description='Inhalt vom Erfasser frei vergebbar, z. Bsp. 4014500008844 oder dbb007ewg.'),
art_id_ref BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Referenzartikelnummer. Hier sind filialfremde Kaufland-Artikelnummern hinterlegt, wenn zutreffend, sonst -1.'),
kunden_text STRING(100) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Freitextfeld, kann bei Rückgabe der Ware befüllt werden.'),
bon_storno_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Markierung für stornierten Satz. 1 = wurde storniert und wird nicht in die Auswertung einbezogen.'),
mit_ware_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL
OPTIONS(description='Zeigt an, ob die Rückgabe mit oder ohne Ware erfolgt ist. Mit Ware = 1, ohne Ware = 0. Ab KW19/2012 stimmig. Wird im Versorgungsprozess aus Return Reason und Return Type Code befüllt.'),
start_bon_zeile DATETIME OPTIONS(description='Zeitstempel bei Beginn der Bewegung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, nb_id, dat, wup_id, art_id, kasse_nr, bon_nr, pos_nr) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Reklamation QBM - MULTISET');