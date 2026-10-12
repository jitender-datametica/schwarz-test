create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_WAWI_ITEM_KEY_TYPE (
	WAWI_ITEM_KEY_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the type of natural key which identifies the Wawi Item.',
	WAWI_ITEM_KEY_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the type of natural key which identifies the Wawi Item.',
	WAWI_ITEM_KEY_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the type of natural key, detailing its format and the meaning of the components.',
	constraint PK_T_WAWI_ITEM_KEY_TYPE primary key (WAWI_ITEM_KEY_TYPE_CD)
)COMMENT='This minor entity defines the type of natural key which identifies a Wawi Item.'
;