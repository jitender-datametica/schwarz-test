create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_PRODUCT_GROUP_HIERARCHY_TYPE_2 (
	PROD_GRP_HIERARCHY_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of hierarchy_2 for product groups.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_GRP_HIERARCHY_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the kind of hierarchy_2 for product groups.',
	constraint PK_T_PRODUCT_GROUP_HIERARCHY_TYPE primary key (PROD_GRP_HIERARCHY_TYPE_CD, LANG_CD)
);