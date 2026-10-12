CREATE OR REPLACE VIEW DBP_VIEW.V_VIS_TAG_KASSE_1 (
   wup_id                                   COMMENT 'Marktnummer'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,dat                                      COMMENT 'Datum im Format JJJJ-MM_1-TT'
  ,kasse_nr                                 COMMENT 'Nummer der Kasse'
  ,kasse_typ_id                             COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default(Sales_1 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'
  ,umsatz_netto                             COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag'
  ,umsatz_netto_zeilenstorno                COMMENT 'Betrag Umsatz ohne Mehrwertsteuer der Zeilenstornos aus ods_bon_verkauf_1 wenn zeilenstorno_fg = 1; Sum((umsatz_brutto*100)/(100+mwst))'
  ,umsatz_netto_bonstorno                   COMMENT 'Betrag Umsatz ohne Mehrwertsteuer der Bonstornos aus ods_bon_kopf. Ein Bonstorno ist eine_1 Löschung des Bons nach vollendeter Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'
  ,umsatz_netto_bonabbruch                  COMMENT 'Betrag Umsatz ohne Mehrwertsteuer der Bonabbrüche aus ods_bon_kopf. Ein Bonabbruch ist eine_1 Löschung des Bons noch während der Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'
  ,anz_artikel                              COMMENT 'Anzahl der Bonzeilenl, hochaggregiert aus den Bondaten'
  ,anz_kunden                               COMMENT 'Anzahl Kunden, aus den Bondaten hochaggregiert'
  ,anz_zeilenstorno                         COMMENT 'Summe der Zeilenstornos aus ods_bon_verkauf_1; zeilenstorno_fg = 1'
  ,anz_bonstorno                            COMMENT 'Summe der Bonstornos aus ods_bon_storno. Ein Bonstorno ist eine_1 Löschung des Bons nach vollendeter Erstellung.'
  ,anz_bonabbruch                           COMMENT 'Summe der Bonabbrüche aus ods_bon_transaction_1 anhand hinterlegter Logik. Ein Bonabbruch ist eine_1 Löschung des Bons noch während der Erstellung.'
  ,kassierzeit                              COMMENT 'Kassierzeit in Sekunden'
  ,registrierzeit                           COMMENT 'Scanzeit. für RO nicht verwendbar. Für CZ ab 01.01.17, für PL, SK, HR, BG ab 01.09.17'
  ,kassiervorgangszeit                      COMMENT 'Registrierzeit inkl. Zahlzeit. Für POSition gibt es nur die Summe. KPOS und LUCAS separat.'
  ,bonanzahl_sug_okf                        COMMENT 'Ohne Kundenfaktor (wird im Frontent beruecksichtigt) - Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe'
  ,anz_bonabbruch_suspended                 COMMENT 'Anzahl der Abbrüche von zurückgestellten Bons (zurückgestellte Bons werden vom Kassensystem in der Nachverarbeitung zu abgebrochenen Bons umgewandelt); suspended_fg = 1. Dabei bedeutet "suspended" den automatischen Abbruch durch das Kassensystem in der Nacht.'
  ,anz_bon_zeilenstorno                     COMMENT 'Anzahl der Bons mit mindestens einem Zeilenstorno (wieder aufgehobene Zeilenstornos werden nicht gezählt)'
  ,anz_bon_kscan                            COMMENT 'Anzahl der mit K-Scan erstellten Bons.'
  ,anz_zeilen_kscan                         COMMENT 'Anzahl der mit K-Scan erstellten Bonzeilen. Wenn beispielsweise ein Artikel_1 zweimal gescannt wurde und in 2 Bonzeilen erscheint, werden hier 2 Bonzeilen gezählt.'
  ,umsatz_netto_bonabbruch_suspended        COMMENT 'Netto Umsatz der Bons, die untertägig zurückgestellt und nachts automatisch von der Kasse abgebrochen wurden.'
  ,umsatz_netto_kscan                       COMMENT 'Mit K-Scan generierter netto Umsatz.'
)
COMMENT = 'VIS - Aggregat Kennzahlen aus den Bondaten pro Tag_1, Markt und Kasse'
 AS 
    SELECT 
        wup_id,
        nb_id,
        mandant_id,
        dat,
        kasse_nr,
        kasse_typ_id,
        wrg_id,
        umsatz_netto,
        umsatz_netto_zeilenstorno,
        umsatz_netto_bonstorno,
        umsatz_netto_bonabbruch,
        anz_artikel,
        anz_kunden,
        anz_zeilenstorno,
        anz_bonstorno,
        anz_bonabbruch,
        kassierzeit,
        registrierzeit,
        kassiervorgangszeit,
        bonanzahl_sug_okf,
        anz_bonabbruch_suspended,
        anz_bon_zeilenstorno,
        anz_bon_kscan,
        anz_zeilen_kscan,
        umsatz_netto_bonabbruch_suspended,
        umsatz_netto_kscan

FROM DBP_DATA.VIS_TAG_KASSE_1 ;