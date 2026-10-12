CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.VIS_TAG_KASSE (
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
DAT DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
KASSE_NR INTEGER NOT NULL OPTIONS(description='Nummer der Kasse'),
KASSE_TYP_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default(Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt'),
KASSIERZEIT INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Kassierzeit in Sekunden'),
ANZ_ARTIKEL INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Anzahl der Bonzeilenl, hochaggregiert aus den Bondaten'),
REGISTRIERZEIT INTEGER
OPTIONS(description='Scanzeit. für RO nicht verwendbar. Für CZ ab 01.01.17, für PL, SK, HR, BG ab 01.09.17'),
UMSATZ_NETTO NUMERIC(29,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
ANZ_KUNDEN INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Anzahl Kunden, aus den Bondaten hochaggregiert'),
KASSIERVORGANGSZEIT INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Registrierzeit inkl. Zahlzeit. Für POSition gibt es nur die Summe. KPOS und LUCAS separat.'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
BONANZAHL_SUG_OKF INTEGER
OPTIONS(description='Ohne Kundenfaktor (wird im Frontent beruecksichtigt) - Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe'),
UMSATZ_NETTO_BONABBRUCH NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Bonabbrüche aus ods_bon_kopf. Ein Bonabbruch ist eine Löschung des Bons noch während der Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'),
UMSATZ_NETTO_BONSTORNO NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Bonstornos aus ods_bon_kopf. Ein Bonstorno ist eine Löschung des Bons nach vollendeter Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'),
UMSATZ_NETTO_ZEILENSTORNO NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Zeilenstornos aus ods_bon_verkauf wenn zeilenstorno_fg = 1; Sum((umsatz_brutto*100)/(100+mwst))'),
ANZ_ZEILENSTORNO INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Summe der Zeilenstornos aus ods_bon_verkauf; zeilenstorno_fg = 1'),
ANZ_BONSTORNO INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Summe der Bonstornos aus ods_bon_storno. Ein Bonstorno ist eine Löschung des Bons nach vollendeter Erstellung.'),
ANZ_BONABBRUCH INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Summe der Bonabbrüche aus ods_bon_transaction anhand hinterlegter Logik. Ein Bonabbruch ist eine Löschung des Bons noch während der Erstellung.'),
ANZ_BONABBRUCH_SUSPENDED INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Abbrüche von zurückgestellten Bons (zurückgestellte Bons werden vom Kassensystem in der Nachverarbeitung zu abgebrochenen Bons umgewandelt); suspended_fg = 1. Dabei bedeutet\"suspended\" den automatischen Abbruch durch das Kassensystem in der Nacht.'),
ANZ_BON_ZEILENSTORNO INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Bons mit mindestens einem Zeilenstorno (wieder aufgehobene Zeilenstornos werden nicht gezählt)'),
ANZ_BON_KSCAN INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Anzahl der mit K-Scan erstellten Bons.'),
ANZ_ZEILEN_KSCAN INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der mit K-Scan erstellten Bonzeilen. Wenn beispielsweise ein Artikel zweimal gescannt wurde und in 2 Bonzeilen erscheint, werden hier 2 Bonzeilen gezählt.'),
UMSATZ_NETTO_BONABBRUCH_SUSPENDED NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Netto Umsatz der Bons, die untertägig zurückgestellt und nachts automatisch von der Kasse abgebrochen wurden.'),
UMSATZ_NETTO_KSCAN NUMERIC(29,4) DEFAULT 0 NOT NULL OPTIONS(description='Mit K-Scan generierter netto Umsatz.'),
PRIMARY KEY (WUP_ID, NB_ID, MANDANT_ID, DAT, KASSE_NR, KASSE_TYP_ID) NOT ENFORCED
) OPTIONS(description='VIS - Aggregat Kennzahlen aus den Bondaten pro Tag, Markt und Kasse');