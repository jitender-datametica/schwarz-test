DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.ARTBEW_SCANNING;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTBEW_SCANNING (
WUP_ID INTEGER NOT NULL OPTIONS(description='WarenUmschlagsPlatz - hier der Markt'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
BEWART_ID INTEGER NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
ART_ID INTEGER NOT NULL OPTIONS(description='DWH-Artikelnummer'),
DAT DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
AKTION_ID STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion aus der Kassenschnittstelle. Referenz zur Tabelle aktion '),
PROMO_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Das Promotion-Flag kennzeichnet einen Promotion-Artikel (z.Bsp. 3 für 2)'),
GTIN_KASSE INTEGER DEFAULT 0 NOT NULL OPTIONS(description='von den Kassensystemen gelieferte GTIN (früher EAN)'),
KASSE_TYP_ID INTEGER NOT NULL
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default (Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office), 5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut), 9 = SCO cashless,  -1 = unbekannt.'),
VORGANG_SCANNED INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Vorgänge, bei denen der Artikel gescannt wurde'),
VORGANG_KEYED INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Vorgänge, bei denen der Artikel mauell erfasst wurde'),
VORGANG_SCANNED_EINZELN INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Vorgänge, bei denen der Artikel einzeln gescannt wurde'),
VORGANG_KEYED_EINZELN INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Vorgänge, bei denen der Artikel einzeln nicht gescannt wurde'),
ANZAHL_BON INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Anzahl der Bons, auf denen der Artikel vorkommt'),
ANZAHL_REGISTRIERT INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Summe aller Artikel, gescannt + keyed, incl. stornierte. Gewichtsartikel als Stück hinterlegt.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WUP_ID, BEWART_ID, GP_ID, NB_ID, ART_ID, DAT, PROMO_FG, GTIN_KASSE, KASSE_TYP_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID, DAT
OPTIONS(description='TP2_AIS - Klon der artbew mit Kennzahlen zu Scanningquote und Bondaten');