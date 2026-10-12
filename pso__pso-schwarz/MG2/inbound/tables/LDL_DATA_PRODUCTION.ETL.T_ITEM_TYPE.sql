create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_ITEM_TYPE (
	ITEM_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the subtype discriminator for items.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	ITEM_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the subtype discriminator for items.',
	constraint PK_T_ITEM_TYPE primary key (ITEM_TYPE_CD, LANG_CD)
);