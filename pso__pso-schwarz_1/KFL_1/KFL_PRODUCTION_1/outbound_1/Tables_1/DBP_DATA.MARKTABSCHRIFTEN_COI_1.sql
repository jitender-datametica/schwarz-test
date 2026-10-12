CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.marktabschriften_coi_1 (
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='\"Der\"\"WUP_1\"\" beinhaltet Märkte und Läger. WUP_1=WarenUmschlagsPlatz\n '),
wup_abschrift_id INTEGER NOT NULL
OPTIONS(description='Belegnummer   numerisch St.   1-  4:   Marktnummer St.   5-  6:   Woche_1 St.   7-10:   lfd. Nummer  Bei Werbeabschriften:  Aktionsnummer, KMO: lagerbew_beleg_id '),
positionsnummer_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Positionsnummer des Einkaufsbeleg   5-stellig numerisch Bei Werbeabschriften: laufende Nummer pro Aktionsnummer KMO: lagerbew_beleg_pos_id '),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE NOT NULL OPTIONS(description='Belegdatum    Format  JJJJ-MM_1-TT'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
lastupd_dat DATE NOT NULL OPTIONS(description='Datum der letzten Änderung      Format  JJJJ-MM_1-TT'),
woche_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Woche_1 des Belegs  Format JJJJWW'),
menge_abschrift NUMERIC(18,3) NOT NULL OPTIONS(description='Abschreibungsmenge'),
abschriftart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Abschriftenart  -  numerisch'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
abschriftbetrag_netto NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Abschriftenbetrag ohne MWSt - wird in der Versorgung errechnet'),
abschriftbetrag_brutto NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Abschriftenbetrag brutto'),
wrg_id STRING(12) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
wv_kz STRING(4) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Kennzeichen Werbeverlängerung.Enthält E für Ersatzartikel, sonst leer'),
wv_grund_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Grund der Werbeverlängerung, z.Bsp 22 Ersatzartikel = Ursprungsartikel, 23 Austauschartikel. Nur im Fall einer WV ist dieses Feld gefüllt'),
vk_aktion_brutto NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Brutto Aktionslverkaufspreis des Artikels aus avkp0'),
vk_brutto NUMERIC(9,2) DEFAULT 0 NOT NULL OPTIONS(description='Brutto Normalverkaufspreis des Artikels aus nvkp0'),
td_update TIMESTAMP,
td_insert TIMESTAMP
);