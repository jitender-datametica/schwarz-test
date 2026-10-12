CREATE TABLE CORE.T_DIM_TRAVEL_BOOKING_COUPON_1 (
	TRAV_BOOKING_COUPON_CD VARCHAR(25) NOT NULL COMMENT 'The codes that customer entered during booking process to activate Coupon.( examples 3001, 3002, etc)',
	TRAV_BOOKING_COUPON_DESCR VARCHAR(250) NOT NULL COMMENT 'The decription for code that customer entered during booking process to activate Coupon.( examples Coupon OoH, Coupon CRM)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_FACT_TRAVEL_BOOKING_COUPON PRIMARY KEY (TRAV_BOOKING_COUPON_CD)
)COMMENT='This minor dimension defines  the list of codes that customer entered during booking process to activate Coupon.'
;