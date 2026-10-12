create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_PRODUCT_VARIANT_RELATIONSHIP_TYPE_1 (
	PROD_VARIANT_REL_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'A code defining the way, how two product variants are related to each other.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_VARIANT_REL_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the way, how two product variants are related to each other.',
	constraint PK_T_PRODUCT_VARIANT_RELATIONSHIP_TYPE primary key (PROD_VARIANT_REL_TYPE_CD, LANG_CD)
);