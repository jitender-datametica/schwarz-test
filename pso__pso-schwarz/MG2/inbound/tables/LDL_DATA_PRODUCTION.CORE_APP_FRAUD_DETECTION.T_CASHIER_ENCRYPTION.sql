create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION (
	CASHIER_HASH VARCHAR(32) NOT NULL COMMENT 'Pseudonymization via country ISO code, store number, cashier number, date (e.g. DE | 1207 | 04 | 2024-04-06) via MD5.',
	BUS_DT DATE NOT NULL COMMENT 'The business date on which the retail event happend.',
	STORE_NR VARCHAR(20) NOT NULL COMMENT 'Natural key of the store the was valid point in time of the hashing or the store number which appear in the receipt (as internal organization). ',
	COUNTRY_ORG_CD VARCHAR(2) NOT NULL COMMENT 'The code of the related business country. (The business country is not identical to a political country.)',
	CASHIER_NR VARCHAR(20) NOT NULL WITH MASKING POLICY #unknown_policy COMMENT 'The number which identifies the cashier. (The number is unique for a given store and a day.)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CASHIER_ENCRYPTION primary key (CASHIER_HASH),
	constraint AK_AK_T_CASHIE unique (BUS_DT, STORE_NR, COUNTRY_ORG_CD, CASHIER_NR)
)COMMENT='A line, which logs the sale or return of a single product within a retail event.'
;