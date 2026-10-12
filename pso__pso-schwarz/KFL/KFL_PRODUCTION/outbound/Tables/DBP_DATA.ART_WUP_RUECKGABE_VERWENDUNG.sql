--==============================================================
-- Table: art_wup_rueckgabe_verwendung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_rueckgabe_verwendung
   generated from Powerdesigner on Donnerstag, 1. Februar 2024 10:43:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_rueckgabe_verwendung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
rueckgabe_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Nummer der Rückgabe. Hochzählender Nummernkreis bei Buchung im Quellsystem.'),
dat_rueckgabe DATE NOT NULL OPTIONS(description='Datum der Rückgabe in der Filiale.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Warenumschlagsplatz. Artikel können in der Regel nur in Filialen an der Info oder Kasse zurückgegeben werden.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
reklamationsgrund_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Grundes für die Reklamation / Rückgabe des Artikels.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
menge_art BIGNUMERIC(38,3) NOT NULL
OPTIONS(description='Anzahl der zurückgegebenen Artikel. Kann sowohl ganzzahlig (Stück) als auch Nachkommastellen haben (bspw. Gewichtsartikel).'),
einh_id STRING(3) NOT NULL OPTIONS(description='Einheit der zurückgegebenen Artikel, bspw. Stück, kg, etc.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_vk_netto_rueckgabe BIGNUMERIC(38,4) NOT NULL
OPTIONS(description='Verkaufspreis des Artikels zum Zeitpunkt der Rückgabe.'),
betrag_vk_netto_kauf BIGNUMERIC(38,4) NOT NULL
OPTIONS(description='Verkaufspreis des Artikels zum Zeitpunkt des Kaufes.'),
dat_mhd DATE
OPTIONS(description='Mindesthaltbarkeitsdatum des Artikels. Wenn MHD nicht lesbar ist, kann hier ein dummy-Datum auftreten. Bei Artikeln ohne MHD ist die Spalte Null.'),
rueckgabe_verwendung_kz STRING(10)
OPTIONS(description='Code definiert die Art der Weiterverwendung eines in der Filiale zurück gegebenen Artikels. Die Weiterverwendung kann sich je nach Artikel und Reklamationsgrund unterscheiden. Beispiele hierfür sind Abschreibungen, Qualitätssicherung, zurück in Verkauf, etc.'),
verarbeitet_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag, welches angibt ob die Rückgabe verarbeitet ist. 1 = verarbeitet, 0 = nicht verarbeitet.'),
dat_verarbeitung DATE OPTIONS(description='Datum der Verarbeitung der Rückgabe.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, rueckgabe_nr, dat_rueckgabe) NOT ENFORCED
)
OPTIONS(description='Tabelle beinhaltet Informationen zur Rückgabe von Artikeln und deren weiteren Verwendung in den Filialen.');