CREATE TABLE ETL_PROCESS.T_ETL_PRODUCT_PRICE_CONDITIONS_1 (
	CONDITION_NUMBER_CD VARCHAR(20) NOT NULL,
	PRICE_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'Code of type of the price - IVP , regular VKP ( standard price) , promotion/campaign price , etc',
	CURR_CD VARCHAR(5) COMMENT 'Currency in which target is set',
	PRICE_VAL NUMBER(38,5) COMMENT 'Valid price in given currency',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	PROD_QTY NUMBER(38,0) COMMENT 'Quantity of products defined in the pricing condition ( fe price is defined per 1000 boxes or 100 boxes in other cases)',
	CONSTRAINT PK_T_ETL_PRODUCT_PRICE_CONDITIONS PRIMARY KEY (CONDITION_NUMBER_CD)
)COMMENT='ETL Support table -  This fact defines the price catalog for lidl internal and customer facing prices.'
;