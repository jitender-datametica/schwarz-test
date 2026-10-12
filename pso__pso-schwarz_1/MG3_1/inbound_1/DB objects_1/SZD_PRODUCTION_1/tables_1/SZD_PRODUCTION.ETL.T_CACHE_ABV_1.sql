create or replace TABLE SZD_PRODUCTION.ETL.T_CACHE_ABV_1 (
	ARTICLE_NUMBER VARCHAR(100),
	ALCOHOL_PERCENTAGE VARCHAR(100),
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	EXCISE_CODE VARCHAR(100),
	ARTIKELNUMMER VARCHAR(100),
	BOTTLE_SIZE VARCHAR(50)
)COMMENT='Major Entity - The customs product is a special product definition used in the \Foreign Trade\ solution to cover both GTS and WWT products. - Source - GS-Upload, GTS/WWT, Excel Report from CDS, Broker (per Mail)'
;