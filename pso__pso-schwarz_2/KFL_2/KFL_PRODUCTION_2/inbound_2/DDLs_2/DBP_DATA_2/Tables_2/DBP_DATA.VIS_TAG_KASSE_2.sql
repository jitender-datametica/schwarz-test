--==============================================================
-- Table: vis_tag_kasse_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vis_tag_kasse_2
   generated from Powerdesigner on Mittwoch, 30. Oktober 2024 16:24:59
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.VIS_TAG_KASSE_2 (
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Marktnummer',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM_2-TT',
   kasse_nr                            NUMBER(38,0)     NOT NULL COMMENT 'Nummer der Kasse',
   kasse_typ_id                        NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default(Sales_2 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   umsatz_netto                        NUMBER(38,4)     NOT NULL DEFAULT 0 COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
   umsatz_netto_zeilenstorno           NUMBER(38,4)     NOT NULL DEFAULT 0 COMMENT 'Betrag Umsatz ohne Mehrwertsteuer der Zeilenstornos aus ods_bon_verkauf_2 wenn zeilenstorno_fg = 1; Sum((umsatz_brutto*100)/(100+mwst))',
   umsatz_netto_bonstorno              NUMBER(38,4)     NOT NULL DEFAULT 0 COMMENT 'Betrag Umsatz ohne Mehrwertsteuer der Bonstornos aus ods_bon_kopf. Ein Bonstorno ist eine_2 Löschung des Bons nach vollendeter Erstellung; sum((umsatz_brutto)-(umsatz_mwst))',
   umsatz_netto_bonabbruch             NUMBER(38,4)     NOT NULL DEFAULT 0 COMMENT 'Betrag Umsatz ohne Mehrwertsteuer der Bonabbrüche aus ods_bon_kopf. Ein Bonabbruch ist eine_2 Löschung des Bons noch während der Erstellung; sum((umsatz_brutto)-(umsatz_mwst))',
   anz_artikel                         NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Bonzeilenl, hochaggregiert aus den Bondaten',
   anz_kunden                          NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl Kunden, aus den Bondaten hochaggregiert',
   anz_zeilenstorno                    NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Summe der Zeilenstornos aus ods_bon_verkauf_2; zeilenstorno_fg = 1',
   anz_bonstorno                       NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Summe der Bonstornos aus ods_bon_storno. Ein Bonstorno ist eine_2 Löschung des Bons nach vollendeter Erstellung.',
   anz_bonabbruch                      NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Summe der Bonabbrüche aus ods_bon_transaction_2 anhand hinterlegter Logik. Ein Bonabbruch ist eine_2 Löschung des Bons noch während der Erstellung.',
   kassierzeit                         NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Kassierzeit in Sekunden',
   registrierzeit                      NUMBER(38,0)     COMMENT 'Scanzeit. für RO nicht verwendbar. Für CZ ab 01.01.17, für PL, SK, HR, BG ab 01.09.17',
   kassiervorgangszeit                 NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Registrierzeit inkl. Zahlzeit. Für POSition gibt es nur die Summe. KPOS und LUCAS separat.',
   bonanzahl_sug_okf                   NUMBER(38,0)     COMMENT 'Ohne Kundenfaktor (wird im Frontent beruecksichtigt) - Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe',
   anz_bonabbruch_suspended            NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Abbrüche von zurückgestellten Bons (zurückgestellte Bons werden vom Kassensystem in der Nachverarbeitung zu abgebrochenen Bons umgewandelt); suspended_fg = 1. Dabei bedeutet "suspended" den automatischen Abbruch durch das Kassensystem in der Nacht.',
   anz_bon_zeilenstorno                NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Bons mit mindestens einem Zeilenstorno (wieder aufgehobene Zeilenstornos werden nicht gezählt)',
   anz_bon_kscan                       NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl der mit K-Scan erstellten Bons.',
   anz_zeilen_kscan                    NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl der mit K-Scan erstellten Bonzeilen. Wenn beispielsweise ein Artikel_2 zweimal gescannt wurde und in 2 Bonzeilen erscheint, werden hier 2 Bonzeilen gezählt.',
   umsatz_netto_bonabbruch_suspended   NUMBER(38,4)     NOT NULL DEFAULT 0 COMMENT 'Netto Umsatz der Bons, die untertägig zurückgestellt und nachts automatisch von der Kasse abgebrochen wurden.',
   umsatz_netto_kscan                  NUMBER(38,4)     NOT NULL DEFAULT 0 COMMENT 'Mit K-Scan generierter netto Umsatz.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_VIS_TAG_KASSE PRIMARY KEY (wup_id, nb_id, mandant_id, dat, kasse_nr, kasse_typ_id) NOT ENFORCED
)  COMMENT = 'VIS - Aggregat Kennzahlen aus den Bondaten pro Tag_2, Markt und Kasse';
