CREATE TABLE CORE.T_DIM_ORDER_CANCELLATION_STATUS (
	ORDER_CANCEL_STATUS_CD VARCHAR(5) NOT NULL COMMENT 'The code for the status of cancellation',
	ORDER_CANCEL_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'The textual description for  status of cancellation',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_ORDER_CANCELLATION_STATUS PRIMARY KEY (ORDER_CANCEL_STATUS_CD)
)COMMENT='This minor dimension defines the status of cancellation'
;