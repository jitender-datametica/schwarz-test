create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_BRAND_TYPE_1 (
	BRAND_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of a brand. It distinguishes between own brands and other retailer brands.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	BRAND_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the kind of a brand.',
	constraint PK_T_BRAND_TYPE primary key (BRAND_TYPE_CD, LANG_CD)
);