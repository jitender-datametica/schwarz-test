--==============================================================
-- Table: artbew_scanning
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_scanning
   generated from Powerdesigner on Donnerstag, 5. Dezember 2024 17:26:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTBEW_SCANNING CLUSTER BY (
     MANDANT_ID,
     DAT 
) (
   wup_id                              INTEGER     NOT NULL COMMENT 'WarenUmschlagsPlatz - hier der Markt',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   bewart_id                           INTEGER     NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              INTEGER     NOT NULL COMMENT 'DWH-Artikelnummer',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
   aktion_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' DEFAULT '          ' COMMENT 'Eindeutige Kennung einer Aktion aus der Kassenschnittstelle. Referenz zur Tabelle aktion ',
   promo_fg                            INTEGER     NOT NULL DEFAULT 0 COMMENT 'Das Promotion-Flag kennzeichnet einen Promotion-Artikel (z.Bsp. 3 für 2)',
   gtin_kasse                          NUMBER(29,0)     NOT NULL DEFAULT 0 COMMENT 'von den Kassensystemen gelieferte GTIN (früher EAN)',
   kasse_typ_id                        INTEGER     NOT NULL COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default (Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office), 5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut), 9 = SCO cashless,  -1 = unbekannt.',
   vorgang_scanned                     INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Vorgänge, bei denen der Artikel gescannt wurde',
   vorgang_keyed                       INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Vorgänge, bei denen der Artikel mauell erfasst wurde',
   vorgang_scanned_einzeln             INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Vorgänge, bei denen der Artikel einzeln gescannt wurde',
   vorgang_keyed_einzeln               INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Vorgänge, bei denen der Artikel einzeln nicht gescannt wurde',
   anzahl_bon                          INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Bons, auf denen der Artikel vorkommt',
   anzahl_registriert                  INTEGER     NOT NULL DEFAULT 0 COMMENT 'Summe aller Artikel, gescannt + keyed, incl. stornierte. Gewichtsartikel als Stück hinterlegt.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTBEW_SCANNING PRIMARY KEY (mandant_id, wup_id, bewart_id, gp_id, nb_id, art_id, dat, aktion_id, promo_fg, gtin_kasse, kasse_typ_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Klon der artbew mit Kennzahlen zu Scanningquote und Bondaten'
;
