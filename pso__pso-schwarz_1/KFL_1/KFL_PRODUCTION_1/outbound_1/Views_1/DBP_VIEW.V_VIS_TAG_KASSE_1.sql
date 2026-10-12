CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vis_tag_kasse_1 (wup_id OPTIONS(description='Marktnummer'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), mandant_id
OPTIONS(description='Mandant_1 im DWH'), dat OPTIONS(description='Datum im Format JJJJ-MM_1-TT'), kasse_nr
OPTIONS(description='Nummer der Kasse'), kasse_typ_id
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default(Sales_1 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), umsatz_netto
OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'), umsatz_netto_zeilenstorno
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Zeilenstornos aus ods_bon_verkauf_1 wenn zeilenstorno_fg = 1; Sum((umsatz_brutto*100)/(100+mwst))'),
umsatz_netto_bonstorno
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Bonstornos aus ods_bon_kopf. Ein Bonstorno ist eine_1 Löschung des Bons nach vollendeter Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'),
umsatz_netto_bonabbruch
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Bonabbrüche aus ods_bon_kopf. Ein Bonabbruch ist eine_1 Löschung des Bons noch während der Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'),
anz_artikel OPTIONS(description='Anzahl der Bonzeilenl, hochaggregiert aus den Bondaten'), anz_kunden
OPTIONS(description='Anzahl Kunden, aus den Bondaten hochaggregiert'), anz_zeilenstorno
OPTIONS(description='Summe der Zeilenstornos aus ods_bon_verkauf_1; zeilenstorno_fg = 1'), anz_bonstorno
OPTIONS(description='Summe der Bonstornos aus ods_bon_storno. Ein Bonstorno ist eine_1 Löschung des Bons nach vollendeter Erstellung.'),
anz_bonabbruch
OPTIONS(description='Summe der Bonabbrüche aus ods_bon_transaction_1 anhand hinterlegter Logik. Ein Bonabbruch ist eine_1 Löschung des Bons noch während der Erstellung.'),
kassierzeit OPTIONS(description='Kassierzeit in Sekunden'), registrierzeit
OPTIONS(description='Scanzeit. für RO nicht verwendbar. Für CZ ab 01.01.17, für PL, SK, HR, BG ab 01.09.17'),
kassiervorgangszeit
OPTIONS(description='Registrierzeit inkl. Zahlzeit. Für POSition gibt es nur die Summe. KPOS und LUCAS separat.'),
bonanzahl_sug_okf
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
OPTIONS(DESCRIPTION = `VIS - AGGREGAT KENNZAHLEN AUS DEN BONDATEN PRO TAG_1, MARKT UND KASSE`) AS SELECT wup_id,
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
FROM kfl_production_dbp_data.vis_tag_kasse_1;