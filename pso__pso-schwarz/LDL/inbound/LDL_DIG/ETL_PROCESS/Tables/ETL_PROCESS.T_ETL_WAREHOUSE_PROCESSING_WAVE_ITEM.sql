CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_PROCESSING_WAVE_ITEM (
	WH_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier(surrogate key) of  warehouse',
	WH_CD VARCHAR(5) COMMENT 'Warehouse code',
	WAVE_ID NUMBER(38,0) NOT NULL COMMENT 'Wave Identifier',
	RDOC_ID VARCHAR(64) NOT NULL COMMENT 'Identifier',
	RITM_ID VARCHAR(64) NOT NULL COMMENT 'Identifier',
	WAVE_ERROR VARCHAR(2) COMMENT 'wave error',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	WH_ORDER_SID NUMBER(38,0) COMMENT 'The unique identifier (sk) for warehouse order',
	WH_ORDER_POS_NR NUMBER(38,0) COMMENT 'The particular position number of a position in an order',
	MAX_WAVE_QTY NUMBER(38,5) COMMENT 'The maximum wave item quantity',
	CONSTRAINT PK_T_ETL_WAREHOUSE_PROCESSING_WAVE_ITEM PRIMARY KEY (WH_SID, WAVE_ID, RDOC_ID, RITM_ID)
)COMMENT='ETL  table to support T_FACT_WAREHOUSE_PROCESSING'
;

