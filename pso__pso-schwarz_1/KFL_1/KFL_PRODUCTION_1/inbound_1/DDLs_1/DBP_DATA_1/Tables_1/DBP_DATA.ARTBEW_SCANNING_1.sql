--==============================================================
-- Table: artbew_scanning_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_scanning_1
   generated from Powerdesigner on Donnerstag, 5. Dezember 2024 17:26:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTBEW_SCANNING_1 CLUSTER BY (
     MANDANT_ID,
     DAT 
) (
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'WarenUmschlagsPlatz - hier der Markt',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   bewart_id                           NUMBER(38,0)     NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
   gp_id                               NUMBER(38,0)     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'DWH-Artikelnummer',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM_1-TT',
   aktion_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' DEFAULT '          ' COMMENT 'Eindeutige Kennung einer Aktion_1 aus der Kassenschnittstelle. Referenz zur Tabelle aktion_1 ',
   promo_fg                            NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Das Promotion-Flag kennzeichnet einen Promotion-Artikel_1 (z.Bsp. 3 für 2)',
   gtin_kasse                          NUMBER(26,0)     NOT NULL DEFAULT 0 COMMENT 'von den Kassensystemen gelieferte GTIN (früher EAN_1)',
   kasse_typ_id                        NUMBER(38,0)     NOT NULL COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default (Sales_1 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office), 5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut), 9 = SCO cashless,  -1 = unbekannt.',
   vorgang_scanned                     NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Vorgänge, bei denen der Artikel_1 gescannt wurde',
   vorgang_keyed                       NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Vorgänge, bei denen der Artikel_1 mauell erfasst wurde',
   vorgang_scanned_einzeln             NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Vorgänge, bei denen der Artikel_1 einzeln gescannt wurde',
   vorgang_keyed_einzeln               NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Vorgänge, bei denen der Artikel_1 einzeln nicht gescannt wurde',
   anzahl_bon                          NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Bons, auf denen der Artikel_1 vorkommt',
   anzahl_registriert                  NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Summe aller Artikel_1, gescannt + keyed, incl. stornierte. Gewichtsartikel als Stück hinterlegt.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTBEW_SCANNING PRIMARY KEY (mandant_id, wup_id, bewart_id, gp_id, nb_id, art_id, dat, aktion_id, promo_fg, gtin_kasse, kasse_typ_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Klon der artbew_1 mit Kennzahlen zu Scanningquote und Bondaten'
;
