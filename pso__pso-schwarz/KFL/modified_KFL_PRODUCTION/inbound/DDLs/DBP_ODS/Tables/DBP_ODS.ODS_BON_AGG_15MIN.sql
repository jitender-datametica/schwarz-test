--==============================================================
-- Table: ods_bon_agg_15min
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_agg_15min
   generated from Powerdesigner on Mittwoch, 30. Oktober 2024 16:25:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS.ODS_BON_AGG_15MIN CLUSTER BY (
     MANDANT_ID,
     DAT 
) (
   dat                                 DATE             NOT NULL COMMENT 'Datum',
   zeit_stunde                         INTEGER     NOT NULL COMMENT 'Volle Stunde (00 bis 23)',
   zeit_15min                          INTEGER     NOT NULL COMMENT 'Zahl (0, 15,30, 45 ) beschreibt das 15-Minuten-Intervall',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprueft',
   kasse_nr                            INTEGER     NOT NULL COMMENT 'Nummer der Kasse',
   kasse_typ_id                        INTEGER     NOT NULL COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default (Sales POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   umsatz_brutto                       NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Umsatz Brutto Betrag',
   umsatz_brutto_zeilenstorno          NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Umsatz Brutto Betrag der Zeilenstornos aus ods_bon_verkauf wenn zeilenstorno_fg = 1',
   umsatz_brutto_bonstorno             NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Umsatz Brutto Betrag der Bonstornos aus ods_bon_storno. Ein Bonstorno ist eine Löschung des Bons nach vollendeter Erstellung.',
   umsatz_brutto_bonabbruch            NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Umsatz Brutto Betrag der Bonabbrüche aus ods_bon_kopf. Ein Bonabruch ist eine Löschung des Bons noch während der Erstellung',
   umsatz_netto                        NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Betrag Umsatz ohne Mehrwertsteuer',
   umsatz_netto_zeilenstorno           NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Betrag Umsatz ohne Mehrwertsteuer der Zeilenstornos aus ods_bon_verkauf wenn zeilenstorno_fg = 1; Sum((umsatz_brutto*100)/(100+mwst))',
   umsatz_netto_bonstorno              NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Betrag Umsatz ohne Mehrwertsteuer der Bonstornos aus ods_bon_kopf. Ein Bonstorno ist eine Löschung des Bons nach vollendeter Erstellung; sum((umsatz_brutto)-(umsatz_mwst))',
   umsatz_netto_bonabbruch             NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Betrag Umsatz ohne Mehrwertsteuer der Bonabbrüche aus ods_bon_kopf. Ein Bonabbruch ist eine Löschung des Bons noch während der Erstellung; sum((umsatz_brutto)-(umsatz_mwst))',
   anz_artikel                         INTEGER     NOT NULL COMMENT 'Anzahl der Bonzeilen',
   anz_kunden                          INTEGER     NOT NULL COMMENT 'Anzahl Kunden',
   anz_zeilenstorno                    INTEGER     NOT NULL DEFAULT 0 COMMENT 'Summe der Zeilenstornos aus ods_bon_verkauf; zeilenstorno_fg = 1',
   anz_bonstorno                       INTEGER     NOT NULL DEFAULT 0 COMMENT 'Summe der Bonstornos aus ods_bon_storno. Ein Bonstorno ist eine Löschung des Bons nach vollendeter Erstellung.',
   anz_bonabbruch                      INTEGER     NOT NULL DEFAULT 0 COMMENT 'Summe der Bonabbrüche aus ods_bon_transaction anhand hinterlegter Logik. Ein Bonabbruch ist eine Löschung des Bons noch während der Erstellung.',
   kassierzeit                         INTEGER     NOT NULL COMMENT 'Kassierzeit (Zeit, in der die Kasse am System angemeldet war) in Sekunden',
   registrierzeit                      INTEGER     NOT NULL DEFAULT 0 COMMENT 'Summe der Zeit für Scanvorgaenge in Sekunden',
   zahlzeit                            INTEGER     NOT NULL DEFAULT 0 COMMENT 'Summe der Zeit fuer Zahlvorgaenge in Sekunden',
   bonanzahl_sug_okf                   INTEGER     NOT NULL DEFAULT 0 COMMENT 'Ohne Kundenfaktor (wird im Frontent beruecksichtigt) - Bons mit mindestens einer positiven Position - einheitliche Definition der Kundenzahl innerhalb der Schwarz-Unternehmensgruppe',
   anz_bonabbruch_suspended            INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Abbrüche von zurückgestellten Bons (zurückgestellte Bons werden vom Kassensystem in der Nachverarbeitung zu abgebrochenen Bons umgewandelt); suspended_fg = 1. Dabei bedeutet "suspended" den automatischen Abbruch durch das Kassensystem in der Nacht.',
   anz_bon_zeilenstorno                INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Bons mit mindestens einem Zeilenstorno (wieder aufgehobene Zeilenstornos werden nicht gezählt)',
   anz_bon_kscan                       INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl der mit K-Scan erstellten Bons.',
   anz_zeilen_kscan                    INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl der mit K-Scan erstellten Bonzeilen. Wenn beispielsweise ein Artikel zweimal gescannt wurde und in 2 Bonzeilen erscheint, werden hier 2 Bonzeilen gezählt.',
   umsatz_netto_bonabbruch_suspended   NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Netto Umsatz der Bons, die untertägig zurückgestellt und nachts automatisch von der Kasse abgebrochen wurden.',
   umsatz_netto_kscan                  NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Mit K-Scan generierter netto Umsatz.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ODS_BON_AGG_15MIN PRIMARY KEY (dat, zeit_stunde, zeit_15min, mandant_id, wup_id, kasse_nr, kasse_typ_id) NOT ENFORCED
)  COMMENT = 'ODS - Aggregat ueber die Bondaten zur Erstellung des Kassenbelegungsberichts';
