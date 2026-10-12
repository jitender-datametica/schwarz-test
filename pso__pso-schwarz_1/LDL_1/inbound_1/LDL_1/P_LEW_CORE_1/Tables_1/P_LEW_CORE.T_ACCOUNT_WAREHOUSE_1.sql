create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_ACCOUNT_WAREHOUSE_1 cluster by (
     CLIENT_ID,
     DWH_CAL_DT 
)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
	LOC_SID_WH NUMBER(38,0) NOT NULL COMMENT 'Warehouse FK auf LOCATION_1 - Surrogate Key Warehouse',
	RECEIPT_ID VARCHAR(100) NOT NULL COMMENT 'Document/Receipt number. Source: T90_WHACCOUNT.C90_FORMNR',
	RECEIPT_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'Indicates the type of CREDIT or DEBIT the document/receipt refers. Source: T90_WHACCOUNT.C90_FORMTYPE',
	RECEIPT_TYPE_DESCR VARCHAR(100) COMMENT 'Description of the type of CREDIT or DEBIT the document refers. Source: T93_TROMTYPE.C93_FORMDESCR',
	ACCOUNT_BALANCE_PAGE_NR NUMBER(38,0) COMMENT 'Indicates the account_1 statement number in ACP / Account_1 Printing Module. Source: T90_WHACCOUNT.C90_PAGENO',
	LOC_SID_STORE NUMBER(38,0) COMMENT 'Store FK auf LOCATION_1 - Surrogate Key STORE',
	DEBIT_VAL NUMBER(18,5) COMMENT 'Indication of the amount by which the company is charged (e.g., for incoming goods or breakage). Sourc: T90_WHACCOUNT.C90_DEBIT',
	CREDIT_VAL NUMBER(18,5) COMMENT 'Specification of the amount by which the company is relieved (e.g., for goods deliveries or returns to the supplier_1). Source: T90_WHACCOUNT.C90_CREDIT',
	DAYEND_DT DATE NOT NULL COMMENT 'Indication of the date on which DAY wrote this entry (company''s daily closing date). Source: T90_WHACCOUNT.C90_DAYENDDATE',
	DWH_CAL_DT DATE NOT NULL COMMENT 'Document/Receipt Date. Source: T90_WHACCOUNT.C90_FORMDATE',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	DEBIT_NET_VAL NUMBER(18,5) COMMENT 'The corresponding net value of the column debit_val. Source: T90_WHACCOUNT.C90_DEBIT_NET',
	CREDIT_NET_VAL NUMBER(18,5) COMMENT 'The corresponding net value of the column credit_val. Source: T90_WHACCOUNT.C90_CREDIT_NET',
	constraint PK_T_ACCOUNT_WAREHOUSE primary key (CLIENT_ID, LOC_SID_WH, RECEIPT_ID, RECEIPT_TYPE_ID, DWH_CAL_DT)
)COMMENT='This table contains the debits and credits of the warehouse accounts splited by receipt type, allowing to calculate the turnover of the warehouse.\n             Source WAWI table: T90_WHACCOUNT_1'
;
