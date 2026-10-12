CREATE TABLE ETL_PROCESS.T_ETL_STOCK_WEBSHOP_ALLOCATION_DAILY_1 (
	WSHOP_CD VARCHAR(5) COMMENT 'The unique code for the Lidl webshop',
	SALE_PROMO_ID NUMBER(38,0) NOT NULL COMMENT 'A unique key from sales_1 promotion line',
	PROD_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for the product',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	TGT_SALES_CNT NUMBER(38,0) COMMENT 'Amount of goods meant to be sold',
	SALE_DT DATE,
	ALLOC_PROMO_CLASS_CD VARCHAR(5) COMMENT 'The code for the indicating if product  is a part of a promotion or main assortment.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   CONSTRAINT PK_T_ETL_STOCK_WEBSHOP_ALLOCATION_DAILY PRIMARY KEY (SALE_PROMO_ID, DWH_VALID_FROM_TMSP)
)COMMENT='The etl table to support t_fact_stock_webshop_allocation_daily , created from excel'
;