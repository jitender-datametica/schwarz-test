create or replace TABLE SZD_PRODUCTION.ETL.T_CACHE_PRODUCT_EXCISE_RATE_EXCEPTIONS_1 (
	COUNTRY_OF_ORIGIN VARCHAR(50),
	COMMODITY_CD VARCHAR(50),
	ADDITIONAL_CD VARCHAR(200),
	PRODUCT_NR VARCHAR(50),
	EXCISE_RATE NUMBER(38,5),
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source'
)COMMENT='Major Entity - The customs product is a special product definition used in the \Foreign Trade\ solution to cover both GTS and WWT products. - Source - GS-Upload, GTS/WWT, Excel Report from CDS, Broker (per Mail)'
;