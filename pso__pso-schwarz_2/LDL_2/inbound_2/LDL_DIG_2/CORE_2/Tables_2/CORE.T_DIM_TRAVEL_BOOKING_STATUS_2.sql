CREATE TABLE CORE.T_DIM_TRAVEL_BOOKING_STATUS_2 (
	TRAV_BOOKING_STATUS_CD VARCHAR(5) NOT NULL COMMENT 'The code for the status_2 of  travel  booking ( A - active , C - cancelled )',
	TRAV_BOOKING_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the status_2 of travel service ',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_TRAVEL_BOOKING_STATUS PRIMARY KEY (TRAV_BOOKING_STATUS_CD)
)COMMENT='This minor dimension defines the status_2 of booking  ( A - active , C - cancelled )\n          '
;