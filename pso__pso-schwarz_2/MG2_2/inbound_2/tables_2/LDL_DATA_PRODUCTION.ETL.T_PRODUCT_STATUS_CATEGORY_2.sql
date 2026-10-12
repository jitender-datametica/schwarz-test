create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_PRODUCT_STATUS_CATEGORY_2 (
	PROD_STATUS_CATEG_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of status_2 lifecycle for products.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_STATUS_CATEG_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the kind of status_2 lifecycle for products.',
	constraint PK_T_PRODUCT_STATUS_CATEGORY primary key (PROD_STATUS_CATEG_CD, LANG_CD)
);