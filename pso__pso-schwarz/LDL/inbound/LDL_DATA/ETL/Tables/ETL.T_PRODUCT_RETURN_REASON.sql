CREATE TABLE ETL.T_PRODUCT_RETURN_REASON (
	PROD_RETURN_REASON_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the reasons why a product was returend to the store.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_RETURN_REASON_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the reasons why a product was returend to the store.',
	CONSTRAINT PK_T_PRODUCT_RETURN_REASON PRIMARY KEY (PROD_RETURN_REASON_SID, LANG_CD)
);
