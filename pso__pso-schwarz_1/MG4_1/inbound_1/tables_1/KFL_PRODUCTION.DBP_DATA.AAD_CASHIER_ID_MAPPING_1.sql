create or replace TABLE KFL_PRODUCTION.DBP_DATA.AAD_CASHIER_ID_MAPPING_1 (
	HASHED_CASHIER_ID VARCHAR(255) NOT NULL COMMENT 'Encrypted (hashed) CashierID',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft.',
	KASSIERER_NR VARCHAR(4) NOT NULL COMMENT 'Nummer des Kassierers.',
	HASH_GENERATION_DT DATE COMMENT 'Last date of the generation of the hashed CashierID',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AAD_CASHIER_ID_MAPPING primary key (HASHED_CASHIER_ID)
)COMMENT=' Contains pseudonymise cashier number'
;