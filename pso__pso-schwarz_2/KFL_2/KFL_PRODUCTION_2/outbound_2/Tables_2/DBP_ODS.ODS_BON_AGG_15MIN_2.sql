--==============================================================
-- Table: ods_bon_agg_15min_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_agg_15min_2
   generated from Powerdesigner on Mittwoch, 30. Oktober 2024 16:25:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.ods_bon_agg_15min_2 (
dat DATE NOT NULL OPTIONS(description='Datum'),
zeit_stunde BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Volle Stunde (00 bis 23)'),
zeit_15min BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Zahl (0, 15,30, 45 ) beschreibt das 15-Minuten-Intervall'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land_2'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprueft'),
kasse_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer der Kasse'),
kasse_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default (Sales_2 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
umsatz_brutto BIGNUMERIC(38,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag'),
umsatz_brutto_zeilenstorno BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Umsatz Brutto Betrag der Zeilenstornos aus ods_bon_verkauf_2 wenn zeilenstorno_fg = 1'),
umsatz_brutto_bonstorno BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Umsatz Brutto Betrag der Bonstornos aus ods_bon_storno. Ein Bonstorno ist eine_2 Löschung des Bons nach vollendeter Erstellung.'),
umsatz_brutto_bonabbruch BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Umsatz Brutto Betrag der Bonabbrüche aus ods_bon_kopf. Ein Bonabruch ist eine_2 Löschung des Bons noch während der Erstellung'),
umsatz_netto BIGNUMERIC(38,4) DEFAULT 0 NOT NULL OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer'),
umsatz_netto_zeilenstorno BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Zeilenstornos aus ods_bon_verkauf_2 wenn zeilenstorno_fg = 1; Sum((umsatz_brutto*100)/(100+mwst))'),
umsatz_netto_bonstorno BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Bonstornos aus ods_bon_kopf. Ein Bonstorno ist eine_2 Löschung des Bons nach vollendeter Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'),
umsatz_netto_bonabbruch BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Bonabbrüche aus ods_bon_kopf. Ein Bonabbruch ist eine_2 Löschung des Bons noch während der Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'),
anz_artikel BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl der Bonzeilen'),
anz_kunden BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Kunden'),
anz_zeilenstorno BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Summe der Zeilenstornos aus ods_bon_verkauf_2; zeilenstorno_fg = 1'),
anz_bonstorno BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Summe der Bonstornos aus ods_bon_storno. Ein Bonstorno ist eine_2 Löschung des Bons nach vollendeter Erstellung.'),
anz_bonabbruch BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Summe der Bonabbrüche aus ods_bon_transaction_2 anhand hinterlegter Logik. Ein Bonabbruch ist eine_2 Löschung des Bons noch während der Erstellung.'),
kassierzeit BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kassierzeit (Zeit_2, in der die Kasse am System angemeldet war) in Sekunden'),
registrierzeit BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Summe der Zeit_2 für Scanvorgaenge in Sekunden'),
zahlzeit BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Summe der Zeit_2 fuer Zahlvorgaenge in Sekunden'),
bonanzahl_sug_okf BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Ohne Kundenfaktor (wird im Frontent beruecksichtigt) - Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe'),
anz_bonabbruch_suspended BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Abbrüche von zurückgestellten Bons (zurückgestellte Bons werden vom Kassensystem in der Nachverarbeitung zu abgebrochenen Bons umgewandelt); suspended_fg = 1. Dabei bedeutet "suspended" den automatischen Abbruch durch das Kassensystem in der Nacht.'),
anz_bon_zeilenstorno BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Bons mit mindestens einem Zeilenstorno (wieder aufgehobene Zeilenstornos werden nicht gezählt)'),
anz_bon_kscan BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Anzahl der mit K-Scan erstellten Bons.'),
anz_zeilen_kscan BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der mit K-Scan erstellten Bonzeilen. Wenn beispielsweise ein Artikel_2 zweimal gescannt wurde und in 2 Bonzeilen erscheint, werden hier 2 Bonzeilen gezählt.'),
umsatz_netto_bonabbruch_suspended BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Netto Umsatz der Bons, die untertägig zurückgestellt und nachts automatisch von der Kasse abgebrochen wurden.'),
umsatz_netto_kscan BIGNUMERIC(38,4) DEFAULT 0 NOT NULL OPTIONS(description='Mit K-Scan generierter netto Umsatz.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (dat, zeit_stunde, zeit_15min, mandant_id, wup_id, kasse_nr, kasse_typ_id) NOT ENFORCED
) CLUSTER BY mandant_id, dat
OPTIONS(description='ODS - Aggregat ueber die Bondaten zur Erstellung des Kassenbelegungsberichts');