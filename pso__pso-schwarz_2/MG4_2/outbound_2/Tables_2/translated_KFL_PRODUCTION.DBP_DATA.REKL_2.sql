CREATE OR REPLACE TABLE kfl_production_dbp_data.rekl_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
dat DATE NOT NULL OPTIONS(description='Datum des Reklamationsvorgangs.'),
wup_id INTEGER NOT NULL OPTIONS(description='Warenumschlagsplatz, an dem die Reklamation erfasst wurde'),
art_id INTEGER NOT NULL
OPTIONS(description='Artikelnummer im DWH. Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
kasse_nr INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Nummer der Kasse - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.'),
bon_nr INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Nummer des Kassenbons - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.'),
pos_nr INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Position auf dem Kassenbon - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.'),
reklamationsgrund_id INTEGER NOT NULL OPTIONS(description='Reklamationskennzeichen, z.Bsp. 30.'),
vk_brutto_re NUMERIC(29,2) NOT NULL OPTIONS(description='Reklamierter Verkaufspreis pro Mengeneinheit.'),
vk_menge_re NUMERIC(29,3) NOT NULL OPTIONS(description='Menge des reklamierten Artikels.'),
gp_id INTEGER NOT NULL OPTIONS(description='Hauptlieferant (Kreditor_2), 6-stellige Lieferantennummer.'),
mhd STRING(6) COLLATE 'und:ci'
OPTIONS(description='Mindesthaltbarkeitsdatum, kommt in verschiedenen Formaten: TTMMJJ oder MMJJ oder JJ.'),
los_charge STRING(20) COLLATE 'und:ci'
OPTIONS(description='Inhalt vom Erfasser frei vergebbar, z. Bsp. 4014500008844 oder dbb007ewg.'),
art_id_ref INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Referenzartikelnummer. Hier sind filialfremde Kaufland-Artikelnummern hinterlegt, wenn zutreffend, sonst -1.'),
kunden_text STRING(100) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Freitextfeld, kann bei Rückgabe der Ware befüllt werden.'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
bon_storno_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Markierung für stornierten Satz. 1 = wurde storniert und wird nicht in die Auswertung einbezogen.'),
mit_ware_fg INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Zeigt an, ob die Rückgabe mit oder ohne Ware erfolgt ist. Mit Ware = 1, ohne Ware = 0. Ab KW19/2012 stimmig. Wird im Versorgungsprozess aus Return Reason und Return Type Code befüllt.'),
start_bon_zeile DATETIME OPTIONS(description='Zeitstempel bei Beginn der Bewegung.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
ean_kasse INTEGER
OPTIONS(description='Die EAN_2 des Artikels.\n            Ein Kauflandartikel im System existiert unter einer Artikelnummer, welche mehrere GTINs zugeordnet haben kann. Beispiel: Alle Ravensburger Puzzle laufen unter einer einzigen Artikelnummer in SAP, da einfach nur allgemein\"Puzzle\" eingekauft wird und der Lieferant selbst entscheidet welche verschiedenen Arten er bereitstellt. Jede Puzzleart hat eine_2 eigene GTIN, aber läuft in SAP unter einer gemeinsamen Nummer (Haupt-GTIN). Die genaue GTIN (EAN_2) des betrachteten Artikels lässt sich deshalb nur an der Kasse genau zuordnen.'),
PRIMARY KEY (mandant_id, nb_id, dat, wup_id, art_id, kasse_nr, bon_nr, pos_nr) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Reklamation QBM - MULTISET');