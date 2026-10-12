create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_PRODUCT_GROUP_STATUS_TYPE (
	PROD_GRP_STATUS_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the lifecycle status for product groups.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_GRP_STATUS_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the lifecycle status for product groups.',
	constraint PK_T_PRODUCT_GROUP_STATUS_TYPE primary key (PROD_GRP_STATUS_TYPE_CD, LANG_CD)
);