CREATE OR REPLACE VIEW DBP_V_ODS.V_ODS_BON_AGG_15MIN_2 (
   dat                                      COMMENT 'Datum'
  ,zeit_stunde                              COMMENT 'Volle Stunde (00 bis 23)'
  ,zeit_15min                               COMMENT 'Zahl (0, 15,30, 45 ) beschreibt das 15-Minuten-Intervall'
  ,mandant_id                               COMMENT 'Mandant_2 im DWH - ein Mandant_2 pro Land_2'
  ,wup_id                                   COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprueft'
  ,kasse_nr                                 COMMENT 'Nummer der Kasse'
  ,kasse_typ_id                             COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default (Sales_2 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'
  ,umsatz_brutto                            COMMENT 'Umsatz Brutto Betrag'
  ,umsatz_brutto_zeilenstorno               COMMENT 'Umsatz Brutto Betrag der Zeilenstornos aus ods_bon_verkauf_2 wenn zeilenstorno_fg = 1'
  ,umsatz_brutto_bonstorno                  COMMENT 'Umsatz Brutto Betrag der Bonstornos aus ods_bon_storno. Ein Bonstorno ist eine_2 Löschung des Bons nach vollendeter Erstellung.'
  ,umsatz_brutto_bonabbruch                 COMMENT 'Umsatz Brutto Betrag der Bonabbrüche aus ods_bon_kopf. Ein Bonabruch ist eine_2 Löschung des Bons noch während der Erstellung'
  ,umsatz_netto                             COMMENT 'Betrag Umsatz ohne Mehrwertsteuer'
  ,umsatz_netto_zeilenstorno                COMMENT 'Betrag Umsatz ohne Mehrwertsteuer der Zeilenstornos aus ods_bon_verkauf_2 wenn zeilenstorno_fg = 1; Sum((umsatz_brutto*100)/(100+mwst))'
  ,umsatz_netto_bonstorno                   COMMENT 'Betrag Umsatz ohne Mehrwertsteuer der Bonstornos aus ods_bon_kopf. Ein Bonstorno ist eine_2 Löschung des Bons nach vollendeter Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'
  ,umsatz_netto_bonabbruch                  COMMENT 'Betrag Umsatz ohne Mehrwertsteuer der Bonabbrüche aus ods_bon_kopf. Ein Bonabbruch ist eine_2 Löschung des Bons noch während der Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'
  ,anz_artikel                              COMMENT 'Anzahl der Bonzeilen'
  ,anz_kunden                               COMMENT 'Anzahl Kunden'
  ,anz_zeilenstorno                         COMMENT 'Summe der Zeilenstornos aus ods_bon_verkauf_2; zeilenstorno_fg = 1'
  ,anz_bonstorno                            COMMENT 'Summe der Bonstornos aus ods_bon_storno. Ein Bonstorno ist eine_2 Löschung des Bons nach vollendeter Erstellung.'
  ,anz_bonabbruch                           COMMENT 'Summe der Bonabbrüche aus ods_bon_transaction_2 anhand hinterlegter Logik. Ein Bonabbruch ist eine_2 Löschung des Bons noch während der Erstellung.'
  ,kassierzeit                              COMMENT 'Kassierzeit (Zeit_2, in der die Kasse am System angemeldet war) in Sekunden'
  ,registrierzeit                           COMMENT 'Summe der Zeit_2 für Scanvorgaenge in Sekunden'
  ,zahlzeit                                 COMMENT 'Summe der Zeit_2 fuer Zahlvorgaenge in Sekunden'
  ,bonanzahl_sug_okf                        COMMENT 'Ohne Kundenfaktor (wird im Frontent beruecksichtigt) - Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe'
  ,anz_bonabbruch_suspended                 COMMENT 'Anzahl der Abbrüche von zurückgestellten Bons (zurückgestellte Bons werden vom Kassensystem in der Nachverarbeitung zu abgebrochenen Bons umgewandelt); suspended_fg = 1. Dabei bedeutet "suspended" den automatischen Abbruch durch das Kassensystem in der Nacht.'
  ,anz_bon_zeilenstorno                     COMMENT 'Anzahl der Bons mit mindestens einem Zeilenstorno (wieder aufgehobene Zeilenstornos werden nicht gezählt)'
  ,anz_bon_kscan                            COMMENT 'Anzahl der mit K-Scan erstellten Bons.'
  ,anz_zeilen_kscan                         COMMENT 'Anzahl der mit K-Scan erstellten Bonzeilen. Wenn beispielsweise ein Artikel_2 zweimal gescannt wurde und in 2 Bonzeilen erscheint, werden hier 2 Bonzeilen gezählt.'
  ,umsatz_netto_bonabbruch_suspended        COMMENT 'Netto Umsatz der Bons, die untertägig zurückgestellt und nachts automatisch von der Kasse abgebrochen wurden.'
  ,umsatz_netto_kscan                       COMMENT 'Mit K-Scan generierter netto Umsatz.'
)
COMMENT = 'ODS - Aggregat ueber die Bondaten zur Erstellung des Kassenbelegungsberichts'
 AS 
    SELECT 
        dat,
        zeit_stunde,
        zeit_15min,
        mandant_id,
        wup_id,
        kasse_nr,
        kasse_typ_id,
        wrg_id,
        umsatz_brutto,
        umsatz_brutto_zeilenstorno,
        umsatz_brutto_bonstorno,
        umsatz_brutto_bonabbruch,
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
        zahlzeit,
        bonanzahl_sug_okf,
        anz_bonabbruch_suspended,
        anz_bon_zeilenstorno,
        anz_bon_kscan,
        anz_zeilen_kscan,
        umsatz_netto_bonabbruch_suspended,
        umsatz_netto_kscan

FROM DBP_ODS.ODS_BON_AGG_15MIN_2 ;