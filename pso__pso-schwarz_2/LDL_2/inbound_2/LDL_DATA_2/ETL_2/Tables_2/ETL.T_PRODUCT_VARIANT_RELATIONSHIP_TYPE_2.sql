CREATE TABLE ETL.T_PRODUCT_VARIANT_RELATIONSHIP_TYPE_2 (
	PROD_VARIANT_REL_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'A code defining the way, how two product variants are related to each other.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_VARIANT_REL_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the way, how two product variants are related to each other.',
	CONSTRAINT PK_T_PRODUCT_VARIANT_RELATIONSHIP_TYPE PRIMARY KEY (PROD_VARIANT_REL_TYPE_CD, LANG_CD)
);
