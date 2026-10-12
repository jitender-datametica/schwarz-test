create or replace TABLE LDL_DIG_PRODUCTION.ETL_PROCESS.T_ETL_WAREHOUSE_PROCESSING_STORAGE_PLACE_2 (
	WH_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier(surrogate key) of  warehouse',
	WH_CD VARCHAR(5) COMMENT 'Warehouse code',
	GU_ID_PARENT VARCHAR(100) NOT NULL COMMENT 'GU Identifier',
	STORAGE_PLACE_LGPLA VARCHAR(20) COMMENT 'Storage Place',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_T_ETL_WAREHOUSE_PROCESSING_STORAGE_PLACE primary key (WH_SID, GU_ID_PARENT)
)COMMENT='ETL  table to support T_FACT_WAREHOUSE_PROCESSING_2'
;