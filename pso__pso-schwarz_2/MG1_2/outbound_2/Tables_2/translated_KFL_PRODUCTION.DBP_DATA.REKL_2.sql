CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.REKL_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
DAT DATE NOT NULL OPTIONS(description='Datum des Reklamationsvorgangs.'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Warenumschlagsplatz, an dem die Reklamation erfasst wurde'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Artikelnummer im DWH. Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
KASSE_NR INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Nummer der Kasse - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.'),
BON_NR INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Nummer des Kassenbons - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.'),
POS_NR INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Position auf dem Kassenbon - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.'),
REKLAMATIONSGRUND_ID INTEGER NOT NULL OPTIONS(description='Reklamationskennzeichen, z.Bsp. 30.'),
VK_BRUTTO_RE NUMERIC(29,2) NOT NULL OPTIONS(description='Reklamierter Verkaufspreis pro Mengeneinheit.'),
VK_MENGE_RE NUMERIC(29,3) NOT NULL OPTIONS(description='Menge des reklamierten Artikels.'),
GP_ID INTEGER NOT NULL OPTIONS(description='Hauptlieferant (Kreditor_2), 6-stellige Lieferantennummer.'),
MHD STRING(6) COLLATE 'und:ci'
OPTIONS(description='Mindesthaltbarkeitsdatum, kommt in verschiedenen Formaten: TTMMJJ oder MMJJ oder JJ.'),
LOS_CHARGE STRING(20) COLLATE 'und:ci'
OPTIONS(description='Inhalt vom Erfasser frei vergebbar, z. Bsp. 4014500008844 oder dbb007ewg.'),
ART_ID_REF INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Referenzartikelnummer. Hier sind filialfremde Kaufland-Artikelnummern hinterlegt, wenn zutreffend, sonst -1.'),
KUNDEN_TEXT STRING(100) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Freitextfeld, kann bei Rückgabe der Ware befüllt werden.'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
BON_STORNO_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Markierung für stornierten Satz. 1 = wurde storniert und wird nicht in die Auswertung einbezogen.'),
MIT_WARE_FG INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Zeigt an, ob die Rückgabe mit oder ohne Ware erfolgt ist. Mit Ware = 1, ohne Ware = 0. Ab KW19/2012 stimmig. Wird im Versorgungsprozess aus Return Reason und Return Type Code befüllt.'),
START_BON_ZEILE DATETIME OPTIONS(description='Zeitstempel bei Beginn der Bewegung.'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
EAN_KASSE INTEGER
OPTIONS(description='Die EAN_2 des Artikels.\n            Ein Kauflandartikel im System existiert unter einer Artikelnummer, welche mehrere GTINs zugeordnet haben kann. Beispiel: Alle Ravensburger Puzzle laufen unter einer einzigen Artikelnummer in SAP, da einfach nur allgemein\"Puzzle\" eingekauft wird und der Lieferant selbst entscheidet welche verschiedenen Arten er bereitstellt. Jede Puzzleart hat eine_2 eigene GTIN, aber läuft in SAP unter einer gemeinsamen Nummer (Haupt-GTIN). Die genaue GTIN (EAN_2) des betrachteten Artikels lässt sich deshalb nur an der Kasse genau zuordnen.'),
PRIMARY KEY (MANDANT_ID, NB_ID, DAT, WUP_ID, ART_ID, KASSE_NR, BON_NR, POS_NR) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Reklamation QBM - MULTISET');