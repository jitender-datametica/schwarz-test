create or replace TABLE KFL_PRODUCTION.DBP_ODS.ODS_BON_KASSENABSCHLUSS (
	BON_ID VARCHAR(100) NOT NULL COMMENT 'eindeutige ID eines Bons, generierter Hashwert',
	BON_DAT DATE NOT NULL COMMENT 'beinhaltet den business_day (Buchungsdatum des Bons, relevant z.Bsp. für artbew)',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprueft',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land',
	ANZ_KUNDEN NUMBER(38,0) NOT NULL COMMENT 'Anzahl Kunden',
	UMSATZ_BRUTTO NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Umsatz Brutto Betrag',
	ANZ_KUNDEN_IMBISS NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Anzahl Imbiss-Kunden',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	ANZ_SCANS NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Anzahl der Scanvorgänge auf Markt - Tag Ebene. Quelle: End of Day Kassen XML der Filialen.',
	SUM_SCAN_SEK NUMBER(38,3) NOT NULL DEFAULT 0 COMMENT 'Summe der Scanzeiten auf Markt - Tag Ebene in Sekunden. Unter Scanzeit versteht man die Zeit die anfällt für einen Scan von der ersten bis zur letzten Bonzeile. Quelle: End of Day Kassen XML der Filiale. ',
	constraint PK_ODS_BON_KASSENABSCHLUSS primary key (BON_ID)
)COMMENT='ODS - KPOS Abstimmsummen pro Tag und Markt aus der end-of-day Transaktion (Kassenabschluss) der Filiale. '
;