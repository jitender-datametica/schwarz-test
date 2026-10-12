CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.MARKTABSCHRIFTEN_COI_1 (
WUP_ID INTEGER NOT NULL OPTIONS(description='\"Der\"\"WUP_1\"\" beinhaltet Märkte und Läger. WUP_1=WarenUmschlagsPlatz\n '),
WUP_ABSCHRIFT_ID INTEGER NOT NULL
OPTIONS(description='Belegnummer   numerisch St.   1-  4:   Marktnummer St.   5-  6:   Woche_1 St.   7-10:   lfd. Nummer  Bei Werbeabschriften:  Aktionsnummer, KMO: lagerbew_beleg_id '),
POSITIONSNUMMER_ID INTEGER NOT NULL
OPTIONS(description='Positionsnummer des Einkaufsbeleg   5-stellig numerisch Bei Werbeabschriften: laufende Nummer pro Aktionsnummer KMO: lagerbew_beleg_pos_id '),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT DATE NOT NULL OPTIONS(description='Belegdatum    Format  JJJJ-MM_1-TT'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
LASTUPD_DAT DATE NOT NULL OPTIONS(description='Datum der letzten Änderung      Format  JJJJ-MM_1-TT'),
WOCHE_ID INTEGER NOT NULL OPTIONS(description='Woche_1 des Belegs  Format JJJJWW'),
MENGE_ABSCHRIFT NUMERIC(18,3) NOT NULL OPTIONS(description='Abschreibungsmenge'),
ABSCHRIFTART_ID INTEGER NOT NULL OPTIONS(description='Abschriftenart  -  numerisch'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
ABSCHRIFTBETRAG_NETTO NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Abschriftenbetrag ohne MWSt - wird in der Versorgung errechnet'),
ABSCHRIFTBETRAG_BRUTTO NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Abschriftenbetrag brutto'),
WRG_ID STRING(12) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
WV_KZ STRING(4) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Kennzeichen Werbeverlängerung.Enthält E für Ersatzartikel, sonst leer'),
WV_GRUND_ID INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Grund der Werbeverlängerung, z.Bsp 22 Ersatzartikel = Ursprungsartikel, 23 Austauschartikel. Nur im Fall einer WV ist dieses Feld gefüllt'),
VK_AKTION_BRUTTO NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Brutto Aktionslverkaufspreis des Artikels aus avkp0'),
VK_BRUTTO NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Brutto Normalverkaufspreis des Artikels aus nvkp0'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
);