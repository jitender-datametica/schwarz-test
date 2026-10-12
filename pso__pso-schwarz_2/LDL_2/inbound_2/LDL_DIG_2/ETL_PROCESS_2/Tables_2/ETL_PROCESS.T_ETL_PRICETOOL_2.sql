CREATE TABLE ETL_PROCESS.T_ETL_PRICETOOL_2 (
	WSHOP_CD VARCHAR(5) NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
	PROD_VARIANT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant',
	PRICE_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'Code of type of the price - IVP , regular VKP ( standard price) , promotion/campaign price , etc',
	PRICE_GROUP_CD VARCHAR(20) COMMENT 'Code of pricing group - internal or customer facing',
	ACTIVE_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The first date from when this record became valid from a business perspective,',
	ACTIVE_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The last date up to when this record was valid from a business perspective,',
	CURR_CD VARCHAR(5) COMMENT 'Currency in which target is set',
	PRICE_VAL NUMBER(38,5) COMMENT 'Valid price in given currency',
	PRICE_CHANGE_REASON_CD VARCHAR(5) COMMENT 'The code for the price change reason ( profit/loss reason   like  327, 326... etc)',
	IS_DELETED_FG BOOLEAN COMMENT 'Indicator for deletion',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	PRICE_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'an identifier of the price record.',
	IS_CREATED_BY_MIGRATION_FG BOOLEAN COMMENT 'Created by migration flag',
	CONSTRAINT PK_T_ETL_PRICETOOL PRIMARY KEY (PRICE_ID)
)COMMENT='ETL Support table - This fact defines the price catalog for lidl internal and customer facing prices.'
;