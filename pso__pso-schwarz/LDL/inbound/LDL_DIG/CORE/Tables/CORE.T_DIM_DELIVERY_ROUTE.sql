CREATE TABLE CORE.T_DIM_DELIVERY_ROUTE (
	DELIVERY_ROUTE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code for the delivery route',
	DELIVERY_ROUTE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for  the delivery route',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_DELIVERY_ROUTE PRIMARY KEY (DELIVERY_ROUTE_CD)
)COMMENT='This minor dimension defines the delivery route detail'
;