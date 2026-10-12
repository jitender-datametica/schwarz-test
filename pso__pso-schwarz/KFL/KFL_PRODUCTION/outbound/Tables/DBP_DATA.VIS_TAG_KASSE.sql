--==============================================================
-- Table: vis_tag_kasse
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vis_tag_kasse
   generated from Powerdesigner on Mittwoch, 30. Oktober 2024 16:24:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vis_tag_kasse (
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
kasse_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer der Kasse'),
kasse_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default(Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
umsatz_netto BIGNUMERIC(38,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
umsatz_netto_zeilenstorno BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Zeilenstornos aus ods_bon_verkauf wenn zeilenstorno_fg = 1; Sum((umsatz_brutto*100)/(100+mwst))'),
umsatz_netto_bonstorno BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Bonstornos aus ods_bon_kopf. Ein Bonstorno ist eine Löschung des Bons nach vollendeter Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'),
umsatz_netto_bonabbruch BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Bonabbrüche aus ods_bon_kopf. Ein Bonabbruch ist eine Löschung des Bons noch während der Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'),
anz_artikel BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Bonzeilenl, hochaggregiert aus den Bondaten'),
anz_kunden BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Anzahl Kunden, aus den Bondaten hochaggregiert'),
anz_zeilenstorno BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Summe der Zeilenstornos aus ods_bon_verkauf; zeilenstorno_fg = 1'),
anz_bonstorno BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Summe der Bonstornos aus ods_bon_storno. Ein Bonstorno ist eine Löschung des Bons nach vollendeter Erstellung.'),
anz_bonabbruch BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Summe der Bonabbrüche aus ods_bon_transaction anhand hinterlegter Logik. Ein Bonabbruch ist eine Löschung des Bons noch während der Erstellung.'),
kassierzeit BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Kassierzeit in Sekunden'),
registrierzeit BIGNUMERIC(38,0)
OPTIONS(description='Scanzeit. für RO nicht verwendbar. Für CZ ab 01.01.17, für PL, SK, HR, BG ab 01.09.17'),
kassiervorgangszeit BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Registrierzeit inkl. Zahlzeit. Für POSition gibt es nur die Summe. KPOS und LUCAS separat.'),
bonanzahl_sug_okf BIGNUMERIC(38,0)
OPTIONS(description='Ohne Kundenfaktor (wird im Frontent beruecksichtigt) - Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe'),
anz_bonabbruch_suspended BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Abbrüche von zurückgestellten Bons (zurückgestellte Bons werden vom Kassensystem in der Nachverarbeitung zu abgebrochenen Bons umgewandelt); suspended_fg = 1. Dabei bedeutet "suspended" den automatischen Abbruch durch das Kassensystem in der Nacht.'),
anz_bon_zeilenstorno BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Bons mit mindestens einem Zeilenstorno (wieder aufgehobene Zeilenstornos werden nicht gezählt)'),
anz_bon_kscan BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Anzahl der mit K-Scan erstellten Bons.'),
anz_zeilen_kscan BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der mit K-Scan erstellten Bonzeilen. Wenn beispielsweise ein Artikel zweimal gescannt wurde und in 2 Bonzeilen erscheint, werden hier 2 Bonzeilen gezählt.'),
umsatz_netto_bonabbruch_suspended BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Netto Umsatz der Bons, die untertägig zurückgestellt und nachts automatisch von der Kasse abgebrochen wurden.'),
umsatz_netto_kscan BIGNUMERIC(38,4) DEFAULT 0 NOT NULL OPTIONS(description='Mit K-Scan generierter netto Umsatz.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wup_id, nb_id, mandant_id, dat, kasse_nr, kasse_typ_id) NOT ENFORCED
) OPTIONS(description='VIS - Aggregat Kennzahlen aus den Bondaten pro Tag, Markt und Kasse');