create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_PRODUCT_RETURN_REASON_2 (
	PROD_RETURN_REASON_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the reasons why a product was returend to the store.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_RETURN_REASON_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the reasons why a product was returend to the store.',
	constraint PK_T_PRODUCT_RETURN_REASON primary key (PROD_RETURN_REASON_SID, LANG_CD)
);