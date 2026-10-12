--==============================================================
-- Table: artbew_scanning
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_scanning
   generated from Powerdesigner on Donnerstag, 5. Dezember 2024 17:26:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artbew_scanning (
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WarenUmschlagsPlatz - hier der Markt'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
bewart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Artikelnummer'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
aktion_id STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion aus der Kassenschnittstelle. Referenz zur Tabelle aktion '),
promo_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Das Promotion-Flag kennzeichnet einen Promotion-Artikel (z.Bsp. 3 für 2)'),
gtin_kasse NUMERIC(26,0) DEFAULT 0 NOT NULL OPTIONS(description='von den Kassensystemen gelieferte GTIN (früher EAN)'),
kasse_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default (Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office), 5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut), 9 = SCO cashless,  -1 = unbekannt.'),
vorgang_scanned BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Vorgänge, bei denen der Artikel gescannt wurde'),
vorgang_keyed BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Vorgänge, bei denen der Artikel mauell erfasst wurde'),
vorgang_scanned_einzeln BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Vorgänge, bei denen der Artikel einzeln gescannt wurde'),
vorgang_keyed_einzeln BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Vorgänge, bei denen der Artikel einzeln nicht gescannt wurde'),
anzahl_bon BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Anzahl der Bons, auf denen der Artikel vorkommt'),
anzahl_registriert BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Summe aller Artikel, gescannt + keyed, incl. stornierte. Gewichtsartikel als Stück hinterlegt.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, bewart_id, gp_id, nb_id, art_id, dat, promo_fg, gtin_kasse, kasse_typ_id) NOT ENFORCED
) CLUSTER BY mandant_id, dat
OPTIONS(description='TP2_AIS - Klon der artbew mit Kennzahlen zu Scanningquote und Bondaten');