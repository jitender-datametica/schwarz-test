DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ODS.ODS_BON_AGG_15MIN;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ODS.ODS_BON_AGG_15MIN (
DAT DATE NOT NULL OPTIONS(description='Datum'),
ZEIT_STUNDE INTEGER NOT NULL OPTIONS(description='Volle Stunde (00 bis 23)'),
ZEIT_15MIN INTEGER NOT NULL OPTIONS(description='Zahl (0, 15,30, 45 ) beschreibt das 15-Minuten-Intervall'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprueft'),
KASSE_NR INTEGER NOT NULL OPTIONS(description='Nummer der Kasse'),
KASSE_TYP_ID INTEGER NOT NULL
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default (Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt'),
UMSATZ_BRUTTO NUMERIC(29,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag'),
UMSATZ_NETTO NUMERIC(29,4) DEFAULT 0 NOT NULL OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer'),
ANZ_ARTIKEL INTEGER NOT NULL OPTIONS(description='Anzahl der Bonzeilen'),
ANZ_KUNDEN INTEGER NOT NULL OPTIONS(description='Anzahl Kunden'),
KASSIERZEIT INTEGER NOT NULL
OPTIONS(description='Kassierzeit (Zeit, in der die Kasse am System angemeldet war) in Sekunden'),
REGISTRIERZEIT INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Summe der Zeit für Scanvorgaenge in Sekunden'),
ZAHLZEIT INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Summe der Zeit fuer Zahlvorgaenge in Sekunden'),
BONANZAHL_SUG_OKF INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Ohne Kundenfaktor (wird im Frontent beruecksichtigt) - Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
UMSATZ_BRUTTO_ZEILENSTORNO NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Umsatz Brutto Betrag der Zeilenstornos aus ods_bon_verkauf wenn zeilenstorno_fg = 1'),
UMSATZ_BRUTTO_BONSTORNO NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Umsatz Brutto Betrag der Bonstornos aus ods_bon_storno. Ein Bonstorno ist eine Löschung des Bons nach vollendeter Erstellung.'),
UMSATZ_BRUTTO_BONABBRUCH NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Umsatz Brutto Betrag der Bonabbrüche aus ods_bon_kopf. Ein Bonabruch ist eine Löschung des Bons noch während der Erstellung'),
UMSATZ_NETTO_ZEILENSTORNO NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Zeilenstornos aus ods_bon_verkauf wenn zeilenstorno_fg = 1; Sum((umsatz_brutto*100)/(100+mwst))'),
UMSATZ_NETTO_BONSTORNO NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Bonstornos aus ods_bon_kopf. Ein Bonstorno ist eine Löschung des Bons nach vollendeter Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'),
UMSATZ_NETTO_BONABBRUCH NUMERIC(29,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag Umsatz ohne Mehrwertsteuer der Bonabbrüche aus ods_bon_kopf. Ein Bonabbruch ist eine Löschung des Bons noch während der Erstellung; sum((umsatz_brutto)-(umsatz_mwst))'),
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
PRIMARY KEY (DAT, ZEIT_STUNDE, ZEIT_15MIN, MANDANT_ID, WUP_ID, KASSE_NR, KASSE_TYP_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID, DAT
OPTIONS(description='ODS - Aggregat ueber die Bondaten zur Erstellung des Kassenbelegungsberichts');