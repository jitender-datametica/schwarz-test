create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_CUSTOMER_IDENTIFICATION_TYPE (
	CUST_IDENT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	CUST_IDENT_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the way how the customer identifies himself in the store, e.g. by his loyalty card.',
	constraint PK_T_CUSTOMER_IDENTIFICATION_TYPE primary key (CUST_IDENT_TYPE_CD, LANG_CD)
);