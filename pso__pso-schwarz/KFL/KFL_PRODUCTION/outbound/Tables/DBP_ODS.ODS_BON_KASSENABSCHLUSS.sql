--==============================================================
-- Table: ods_bon_kassenabschluss
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_kassenabschluss
   generated from Powerdesigner on Montag, 16. Oktober 2023 15:12:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.ods_bon_kassenabschluss (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land'),
bon_id STRING(100) NOT NULL OPTIONS(description='eindeutige ID eines Bons, generierter Hashwert'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprueft'),
bon_dat DATE NOT NULL
OPTIONS(description='beinhaltet den business_day (Buchungsdatum des Bons, relevant z.Bsp. für artbew)'),
umsatz_brutto NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag'),
anz_kunden BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Kunden'),
anz_kunden_imbiss BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Anzahl Imbiss-Kunden'),
anz_scans BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Scanvorgänge auf Markt - Tag Ebene. Quelle: End of Day Kassen XML der Filialen.'),
sum_scan_sek BIGNUMERIC(38,3) DEFAULT 0 NOT NULL
OPTIONS(description='Summe der Scanzeiten auf Markt - Tag Ebene in Sekunden. Unter Scanzeit versteht man die Zeit die anfällt für einen Scan von der ersten bis zur letzten Bonzeile. Quelle: End of Day Kassen XML der Filiale. '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bon_id) NOT ENFORCED
)
OPTIONS(description='ODS - KPOS Abstimmsummen pro Tag und Markt aus der end-of-day Transaktion (Kassenabschluss) der Filiale. ');