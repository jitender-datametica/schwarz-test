create or replace TABLE LDL_DIG_PRODUCTION.CORE.T_DIM_WAREHOUSE_2 (
	WH_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the warehouse',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	WH_CD VARCHAR(5) NOT NULL COMMENT 'A short unique code for the warehouses which receives the deliveries',
	WH_NAME VARCHAR(100) COMMENT 'The name by which the warehouse is known.',
	WH_TYPE_CD VARCHAR(5) COMMENT 'The code forthe type for the warehouse (Außenlager, Versandlager, Zwischenlager)',
	IS_RUN_BY_EXT_COMPANY BOOLEAN COMMENT 'Flag shows is warehouse run by external company  (there is no difference between internal / external run companies, only necessary for top mgmt reporting)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	SRC_TABLE_NAME VARCHAR(100) COMMENT 'The name of the source tables',
	WH_STORAGE_TYPE_CD VARCHAR(5) COMMENT 'The code for the type of warehouse storage ((KK,GT ...)',
	IS_WINE_STORAGE_FG BOOLEAN COMMENT 'Flag shows if the warehouse stores wine&spirits(Großbeeren currently is GT + Wein)',
	constraint PK_T_DIM_WAREHOUSE primary key (WH_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A warehouse is a physical building which is used for storing and trans-shipping goods. In many cases it is also the home of the associated sales_2 organization'
;