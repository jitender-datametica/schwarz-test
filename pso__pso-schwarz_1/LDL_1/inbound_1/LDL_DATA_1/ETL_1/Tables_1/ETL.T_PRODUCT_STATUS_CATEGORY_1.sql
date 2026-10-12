CREATE TABLE ETL.T_PRODUCT_STATUS_CATEGORY_1 (
	PROD_STATUS_CATEG_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of status_1 lifecycle for products.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_STATUS_CATEG_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the kind of status_1 lifecycle for products.',
	CONSTRAINT PK_T_PRODUCT_STATUS_CATEGORY PRIMARY KEY (PROD_STATUS_CATEG_CD, LANG_CD)
);
