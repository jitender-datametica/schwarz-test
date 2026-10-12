CREATE OR REPLACE VIEW DBP_VIEW.V_ARTBEW_SCANNING_2 (
   wup_id                                   COMMENT 'WarenUmschlagsPlatz - hier der Markt'
  ,mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,bewart_id                                COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'
  ,gp_id                                    COMMENT 'Geschäftspartner - ID (Lieferanten - ID)'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,art_id                                   COMMENT 'DWH-Artikelnummer'
  ,dat                                      COMMENT 'Datum im Format JJJJ-MM_2-TT'
  ,aktion_id                                COMMENT 'Eindeutige Kennung einer Aktion_2 aus der Kassenschnittstelle. Referenz zur Tabelle aktion_2 '
  ,promo_fg                                 COMMENT 'Das Promotion-Flag kennzeichnet einen Promotion-Artikel_2 (z.Bsp. 3 für 2)'
  ,gtin_kasse                               COMMENT 'von den Kassensystemen gelieferte GTIN (früher EAN_2)'
  ,kasse_typ_id                             COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default (Sales_2 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office), 5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut), 9 = SCO cashless,  -1 = unbekannt.'
  ,vorgang_scanned                          COMMENT 'Anzahl der Vorgänge, bei denen der Artikel_2 gescannt wurde'
  ,vorgang_keyed                            COMMENT 'Anzahl der Vorgänge, bei denen der Artikel_2 mauell erfasst wurde'
  ,vorgang_scanned_einzeln                  COMMENT 'Anzahl der Vorgänge, bei denen der Artikel_2 einzeln gescannt wurde'
  ,vorgang_keyed_einzeln                    COMMENT 'Anzahl der Vorgänge, bei denen der Artikel_2 einzeln nicht gescannt wurde'
  ,anzahl_bon                               COMMENT 'Anzahl der Bons, auf denen der Artikel_2 vorkommt'
  ,anzahl_registriert                       COMMENT 'Summe aller Artikel_2, gescannt + keyed, incl. stornierte. Gewichtsartikel als Stück hinterlegt.'
)
COMMENT = 'TP2_AIS - Klon der artbew_2 mit Kennzahlen zu Scanningquote und Bondaten'
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

FROM DBP_DATA.ARTBEW_SCANNING_2 
;