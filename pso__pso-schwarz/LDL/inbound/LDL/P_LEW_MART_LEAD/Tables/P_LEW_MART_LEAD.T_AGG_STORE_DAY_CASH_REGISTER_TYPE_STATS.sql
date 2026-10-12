create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.T_AGG_STORE_DAY_CASH_REGISTER_TYPE_STATS (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
	LOC_SID NUMBER(38,0) NOT NULL COMMENT 'Filiale; FK auf LOCATION; ',
	DWH_CAL_DT DATE NOT NULL COMMENT 'Belegdatum / BON Datum; WAWI-DWH',
	REGISTER_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'TIL: Standard Till; SCO: Self-Check-Out ; SSC: Self-Scanning',
	SCO_OPEN_TIME_SEC_TOTAL NUMBER(38,0) NOT NULL COMMENT 'Open Time in seconds between first scan of the day until last scan of the day in SCO-Zone; 0 for TIL',
	DUR_PREPARE_SEC_TOTAL NUMBER(38,0) COMMENT 'tbd',
	DUR_WAIT_SEC_TOTAL NUMBER(38,0) NOT NULL COMMENT 'Waiting time in seconds; 0 for SCO and SSC; source: receiptline',
	DUR_SCAN_SEC_TOTAL NUMBER(38,0) NOT NULL COMMENT 'Scan time in seconds; source: receiptline',
	DUR_PAY_SEC_TOTAL NUMBER(38,0) NOT NULL COMMENT 'Pay time in seconds; source: receiptline',
	DUR_PROC_SEC_TOTAL NUMBER(38,0) NOT NULL COMMENT 'Wait + Scan + Pay time; source receiptline',
	SALES_PIECES_TOTAL NUMBER(18,5) NOT NULL COMMENT 'Sales Pieces (Abverkauf Gesamt)',
	CUSTOMER_COUNT_TOTAL NUMBER(38,0) NOT NULL COMMENT 'Sales Pieces (Abverkauf Gesamt)',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'DWH load Identifier',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH',
	ASPECT_ID NUMBER(38,0) COMMENT 'Gesellschaftstyp: 1=BGES, 2=VGES',
	SCO_ACTIVE NUMBER(38,0) COMMENT 'Anzahl aktiver SCOs oder SSCs',
	SALES_PIECES_TOTAL_OG NUMBER(18,5) COMMENT 'Sales Pieces (Abverkauf Obst+Gemüse)',
	SALES_PIECES_TOTAL_BAKEOFF NUMBER(18,5) COMMENT 'Sales Pieces (Abverkauf Bake-Off)',
	CASHIER_PERFORMANCE NUMBER(38,0) COMMENT 'Cashier Performance (Kassierleistung)'
)COMMENT='Kassierleistung'
;
