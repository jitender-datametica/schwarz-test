CREATE OR REPLACE VIEW DBP_VIEW.V_ARTBEW_SCANNING (
   wup_id                                   COMMENT 'WarenUmschlagsPlatz - hier der Markt'
  ,mandant_id                               COMMENT 'Mandant im DWH'
  ,bewart_id                                COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'
  ,gp_id                                    COMMENT 'Geschäftspartner - ID (Lieferanten - ID)'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,art_id                                   COMMENT 'DWH-Artikelnummer'
  ,dat                                      COMMENT 'Datum im Format JJJJ-MM-TT'
  ,aktion_id                                COMMENT 'Eindeutige Kennung einer Aktion aus der Kassenschnittstelle. Referenz zur Tabelle aktion '
  ,promo_fg                                 COMMENT 'Das Promotion-Flag kennzeichnet einen Promotion-Artikel (z.Bsp. 3 für 2)'
  ,gtin_kasse                               COMMENT 'von den Kassensystemen gelieferte GTIN (früher EAN)'
  ,kasse_typ_id                             COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default (Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office), 5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut), 9 = SCO cashless,  -1 = unbekannt.'
  ,vorgang_scanned                          COMMENT 'Anzahl der Vorgänge, bei denen der Artikel gescannt wurde'
  ,vorgang_keyed                            COMMENT 'Anzahl der Vorgänge, bei denen der Artikel mauell erfasst wurde'
  ,vorgang_scanned_einzeln                  COMMENT 'Anzahl der Vorgänge, bei denen der Artikel einzeln gescannt wurde'
  ,vorgang_keyed_einzeln                    COMMENT 'Anzahl der Vorgänge, bei denen der Artikel einzeln nicht gescannt wurde'
  ,anzahl_bon                               COMMENT 'Anzahl der Bons, auf denen der Artikel vorkommt'
  ,anzahl_registriert                       COMMENT 'Summe aller Artikel, gescannt + keyed, incl. stornierte. Gewichtsartikel als Stück hinterlegt.'
)
COMMENT = 'TP2_AIS - Klon der artbew mit Kennzahlen zu Scanningquote und Bondaten'
 AS 
    SELECT 
        wup_id,
        mandant_id,
        bewart_id,
        gp_id,
        nb_id,
        art_id,
        dat,
        aktion_id,
        promo_fg,
        gtin_kasse,
        kasse_typ_id,
        vorgang_scanned,
        vorgang_keyed,
        vorgang_scanned_einzeln,
        vorgang_keyed_einzeln,
        anzahl_bon,
        anzahl_registriert

FROM DBP_DATA.ARTBEW_SCANNING 
;