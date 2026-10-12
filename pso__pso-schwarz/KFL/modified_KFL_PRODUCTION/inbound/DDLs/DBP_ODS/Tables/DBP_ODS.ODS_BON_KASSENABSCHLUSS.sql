--==============================================================
-- Table: ods_bon_kassenabschluss
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_kassenabschluss
   generated from Powerdesigner on Montag, 16. Oktober 2023 15:12:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS.ODS_BON_KASSENABSCHLUSS (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land',
   bon_id                              VARCHAR(100)     NOT NULL COMMENT 'eindeutige ID eines Bons, generierter Hashwert',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprueft',
   bon_dat                             DATE             NOT NULL COMMENT 'beinhaltet den business_day (Buchungsdatum des Bons, relevant z.Bsp. für artbew)',
   umsatz_brutto                       NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Umsatz Brutto Betrag',
   anz_kunden                          INTEGER     NOT NULL COMMENT 'Anzahl Kunden',
   anz_kunden_imbiss                   INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl Imbiss-Kunden',
   anz_scans                           INTEGER     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Scanvorgänge auf Markt - Tag Ebene. Quelle: End of Day Kassen XML der Filialen.',
   sum_scan_sek                        NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Summe der Scanzeiten auf Markt - Tag Ebene in Sekunden. Unter Scanzeit versteht man die Zeit die anfällt für einen Scan von der ersten bis zur letzten Bonzeile. Quelle: End of Day Kassen XML der Filiale. ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ODS_BON_KASSENABSCHLUSS PRIMARY KEY (bon_id) NOT ENFORCED
)  COMMENT = 'ODS - KPOS Abstimmsummen pro Tag und Markt aus der end-of-day Transaktion (Kassenabschluss) der Filiale. ';
