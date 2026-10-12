CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ODS.ODS_BON_KASSENABSCHLUSS_1 (
BON_ID STRING(100) NOT NULL OPTIONS(description='eindeutige ID eines Bons, generierter Hashwert'),
BON_DAT DATE NOT NULL
OPTIONS(description='beinhaltet den business_day (Buchungsdatum des Bons, relevant z.Bsp. für artbew_1)'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprueft'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land_1'),
ANZ_KUNDEN INTEGER NOT NULL OPTIONS(description='Anzahl Kunden'),
UMSATZ_BRUTTO NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag'),
ANZ_KUNDEN_IMBISS INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Anzahl Imbiss-Kunden'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
ANZ_SCANS INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der Scanvorgänge auf Markt - Tag_1 Ebene. Quelle: End of Day Kassen XML der Filialen.'),
SUM_SCAN_SEK NUMERIC(29,3) DEFAULT 0 NOT NULL
OPTIONS(description='Summe der Scanzeiten auf Markt - Tag_1 Ebene in Sekunden. Unter Scanzeit versteht man die Zeit_1 die anfällt für einen Scan von der ersten bis zur letzten Bonzeile. Quelle: End of Day Kassen XML der Filiale. '),
PRIMARY KEY (BON_ID) NOT ENFORCED
)
OPTIONS(description='ODS - KPOS Abstimmsummen pro Tag_1 und Markt aus der end-of-day Transaktion (Kassenabschluss) der Filiale. ');