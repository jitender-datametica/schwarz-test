CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_ods_bon_agg_15min_1 (dat OPTIONS(description='Datum'), zeit_stunde
OPTIONS(description='Volle Stunde (00 bis 23)'), zeit_15min
OPTIONS(description='Zahl (0, 15,30, 45 ) beschreibt das 15-Minuten-Intervall'), mandant_id
OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land_1'), wup_id
OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprueft'), kasse_nr
OPTIONS(description='Nummer der Kasse'), kasse_typ_id
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default (Sales_1 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt'),
wrg_id OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'), umsatz_brutto
OPTIONS(description='Umsatz Brutto Betrag'), umsatz_brutto_zeilenstorno
OPTIONS(description='Umsatz Brutto Betrag der Zeilenstornos aus ods_bon_verkauf_1 wenn zeilenstorno_fg = 1'),
umsatz_brutto_bonstorno
OPTIONS(description='Umsatz Brutto Betrag der Bonstornos aus ods_bon_storno. Ein Bonstorno ist eine_1 Löschung des Bons nach vollendeter Erstellung.'),
umsatz_brutto_bonabbruch
OPTIONS(description='Umsatz Brutto Betrag der Bonabbrüche aus ods_bon_kopf. Ein Bonabruch ist eine_1 Löschung des Bons noch während der Erstellung'),
umsatz_netto OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer'), umsatz_netto_zeilenstorno
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Zeilenstornos aus ods_bon_verkauf_1 wenn zeilenstorno_fg = 1; Sum((umsatz_brutto*100)/(100+mwst))'),
umsatz_netto_bonstorno
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Bonstornos aus ods_bon_kopf. Ein Bonstorno ist eine_1 Löschung des Bons nach vollendeter Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'),
umsatz_netto_bonabbruch
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Bonabbrüche aus ods_bon_kopf. Ein Bonabbruch ist eine_1 Löschung des Bons noch während der Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'),
anz_artikel OPTIONS(description='Anzahl der Bonzeilen'), anz_kunden OPTIONS(description='Anzahl Kunden'),
anz_zeilenstorno OPTIONS(description='Summe der Zeilenstornos aus ods_bon_verkauf_1; zeilenstorno_fg = 1'), anz_bonstorno
OPTIONS(description='Summe der Bonstornos aus ods_bon_storno. Ein Bonstorno ist eine_1 Löschung des Bons nach vollendeter Erstellung.'),
anz_bonabbruch
OPTIONS(description='Summe der Bonabbrüche aus ods_bon_transaction_1 anhand hinterlegter Logik. Ein Bonabbruch ist eine_1 Löschung des Bons noch während der Erstellung.'),
kassierzeit OPTIONS(description='Kassierzeit (Zeit_1, in der die Kasse am System angemeldet war) in Sekunden'),
registrierzeit OPTIONS(description='Summe der Zeit_1 für Scanvorgaenge in Sekunden'), zahlzeit
OPTIONS(description='Summe der Zeit_1 fuer Zahlvorgaenge in Sekunden'), bonanzahl_sug_okf
OPTIONS(description='Ohne Kundenfaktor (wird im Frontent beruecksichtigt) - Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe'),
anz_bonabbruch_suspended
OPTIONS(description='Anzahl der Abbrüche von zurückgestellten Bons (zurückgestellte Bons werden vom Kassensystem in der Nachverarbeitung zu abgebrochenen Bons umgewandelt); suspended_fg = 1. Dabei bedeutet "suspended" den automatischen Abbruch durch das Kassensystem in der Nacht.'),
anz_bon_zeilenstorno
OPTIONS(description='Anzahl der Bons mit mindestens einem Zeilenstorno (wieder aufgehobene Zeilenstornos werden nicht gezählt)'),
anz_bon_kscan OPTIONS(description='Anzahl der mit K-Scan erstellten Bons.'), anz_zeilen_kscan
OPTIONS(description='Anzahl der mit K-Scan erstellten Bonzeilen. Wenn beispielsweise ein Artikel_1 zweimal gescannt wurde und in 2 Bonzeilen erscheint, werden hier 2 Bonzeilen gezählt.'),
umsatz_netto_bonabbruch_suspended
OPTIONS(description='Netto Umsatz der Bons, die untertägig zurückgestellt und nachts automatisch von der Kasse abgebrochen wurden.'),
umsatz_netto_kscan OPTIONS(description='Mit K-Scan generierter netto Umsatz.'))
OPTIONS(DESCRIPTION = `ODS - AGGREGAT UEBER DIE BONDATEN ZUR ERSTELLUNG DES KASSENBELEGUNGSBERICHTS`) AS SELECT dat,
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
FROM kfl_production_dbp_ods.ods_bon_agg_15min_1;