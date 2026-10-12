--==============================================================
-- Table: ods_bon_kassenabschluss_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_kassenabschluss_1
   generated from Powerdesigner on Montag, 16. Oktober 2023 15:12:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_ODS.ODS_BON_KASSENABSCHLUSS_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land_1',
   bon_id                              VARCHAR(100)     NOT NULL COMMENT 'eindeutige ID eines Bons, generierter Hashwert',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprueft',
   bon_dat                             DATE             NOT NULL COMMENT 'beinhaltet den business_day (Buchungsdatum des Bons, relevant z.Bsp. für artbew_1)',
   umsatz_brutto                       NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Umsatz Brutto Betrag',
   anz_kunden                          NUMBER(38,0)     NOT NULL COMMENT 'Anzahl Kunden',
   anz_kunden_imbiss                   NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl Imbiss-Kunden',
   anz_scans                           NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Anzahl der Scanvorgänge auf Markt - Tag_1 Ebene. Quelle: End of Day Kassen XML der Filialen.',
   sum_scan_sek                        NUMBER(38,3)     NOT NULL DEFAULT 0 COMMENT 'Summe der Scanzeiten auf Markt - Tag_1 Ebene in Sekunden. Unter Scanzeit versteht man die Zeit_1 die anfällt für einen Scan von der ersten bis zur letzten Bonzeile. Quelle: End of Day Kassen XML der Filiale. ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ODS_BON_KASSENABSCHLUSS PRIMARY KEY (bon_id) NOT ENFORCED
)  COMMENT = 'ODS - KPOS Abstimmsummen pro Tag_1 und Markt aus der end-of-day Transaktion (Kassenabschluss) der Filiale. ';
