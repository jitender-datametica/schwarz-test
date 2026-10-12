create or replace TABLE KFL_PRODUCTION.DBP_DATA.ARTBEW_SCANNING_2 cluster by (
     MANDANT_ID,
     DAT 
)(
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'WarenUmschlagsPlatz - hier der Markt',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	BEWART_ID NUMBER(38,0) NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Artikelnummer',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM_2-TT',
	AKTION_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' DEFAULT '          ' COMMENT 'Eindeutige Kennung einer Aktion_2 aus der Kassenschnittstelle. Referenz zur Tabelle aktion_2 ',
	PROMO_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Das Promotion-Flag kennzeichnet einen Promotion-Artikel_2 (z.Bsp. 3 für 2)',
	GTIN_KASSE NUMBER(26,0) NOT NULL DEFAULT 0 COMMENT 'von den Kassensystemen gelieferte GTIN (früher EAN_2)',
	KASSE_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default (Sales_2 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office), 5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut), 9 = SCO cashless,  -1 = unbekannt.',
	VORGANG_SCANNED NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Anzahl der Vorgänge, bei denen der Artikel_2 gescannt wurde',
	VORGANG_KEYED NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Anzahl der Vorgänge, bei denen der Artikel_2 mauell erfasst wurde',
	VORGANG_SCANNED_EINZELN NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Anzahl der Vorgänge, bei denen der Artikel_2 einzeln gescannt wurde',
	VORGANG_KEYED_EINZELN NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Anzahl der Vorgänge, bei denen der Artikel_2 einzeln nicht gescannt wurde',
	ANZAHL_BON NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Anzahl der Bons, auf denen der Artikel_2 vorkommt',
	ANZAHL_REGISTRIERT NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Summe aller Artikel_2, gescannt + keyed, incl. stornierte. Gewichtsartikel als Stück hinterlegt.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ARTBEW_SCANNING primary key (MANDANT_ID, WUP_ID, BEWART_ID, GP_ID, NB_ID, ART_ID, DAT, AKTION_ID, PROMO_FG, GTIN_KASSE, KASSE_TYP_ID)
)COMMENT='TP2_AIS - Klon der artbew_2 mit Kennzahlen zu Scanningquote und Bondaten'
;