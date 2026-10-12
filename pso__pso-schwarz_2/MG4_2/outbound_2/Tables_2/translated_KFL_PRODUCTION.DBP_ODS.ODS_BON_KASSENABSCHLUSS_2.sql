CREATE OR REPLACE TABLE kfl_production_dbp_ods.ods_bon_kassenabschluss_2 (
bon_id STRING(100) NOT NULL OPTIONS(description='eindeutige ID eines Bons, generierter Hashwert'),
bon_dat DATE NOT NULL
OPTIONS(description='beinhaltet den business_day (Buchungsdatum des Bons, relevant z.Bsp. für artbew_2)'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprueft'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land_2'),
anz_kunden INTEGER NOT NULL OPTIONS(description='Anzahl Kunden'),
umsatz_brutto NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag'),
anz_kunden_imbiss INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Anzahl Imbiss-Kunden'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
anz_scans INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Scanvorgänge auf Markt - Tag_2 Ebene. Quelle: End of Day Kassen XML der Filialen.'),
sum_scan_sek NUMERIC(29,3) DEFAULT 0 NOT NULL
OPTIONS(description='Summe der Scanzeiten auf Markt - Tag_2 Ebene in Sekunden. Unter Scanzeit versteht man die Zeit_2 die anfällt für einen Scan von der ersten bis zur letzten Bonzeile. Quelle: End of Day Kassen XML der Filiale. '),
PRIMARY KEY (bon_id) NOT ENFORCED
)
OPTIONS(description='ODS - KPOS Abstimmsummen pro Tag_2 und Markt aus der end-of-day Transaktion (Kassenabschluss) der Filiale. ');