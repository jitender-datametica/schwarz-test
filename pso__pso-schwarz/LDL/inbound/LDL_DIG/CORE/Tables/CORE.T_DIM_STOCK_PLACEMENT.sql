CREATE TABLE CORE.T_DIM_STOCK_PLACEMENT (
	STOCK_PLACEMENT_CD VARCHAR(10) NOT NULL COMMENT 'The code which identifies the storage type indicator for stock placement',
	STOCK_PLACEMENT_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for  the storage type indicator for stock placement',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_STOCK_PLACEMENT PRIMARY KEY (STOCK_PLACEMENT_CD)
)COMMENT='This minor dimension defines the storage type indicator for stock placement'
;