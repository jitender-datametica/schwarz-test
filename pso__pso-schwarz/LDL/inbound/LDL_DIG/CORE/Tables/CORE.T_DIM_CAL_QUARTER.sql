CREATE TABLE CORE.T_DIM_CAL_QUARTER (
	CY_QUARTER NUMBER(38,0) NOT NULL COMMENT 'The quarter as a number of the form YYYYQX, where YYYY is the calendar year and QX is quarter of the calendar year.',
	CY NUMBER(38,0) NOT NULL COMMENT 'The calendar year as a number in the form YYYY. Eg. 2019',
	BUS_YEAR NUMBER(38,0) NOT NULL COMMENT 'The business year as a number in the form YYYY. Eg. 2019.',
	QUARTER_OF_CAL_YEAR VARCHAR(5) NOT NULL COMMENT 'The quarter of the calendar year as a number using the convention Q1 = 1 ... Q4 = 4.',
	QUARTER_OF_BUS_YEAR VARCHAR(5) NOT NULL COMMENT 'The quarter of the business year (starting in March) as a number using the convention ',
	CAL_QUARTER_BEGIN_DT DATE NOT NULL COMMENT 'The first day of the quarter in the form YYYY-MM-DD.',
	CAL_QUARTER_END_DT DATE NOT NULL COMMENT 'The last day of the quarter in the form YYYY-MM-DD. ',
	CAL_QUARTER_PREV_1M NUMBER(38,0) NOT NULL COMMENT 'The calendar quarter one quarter ago as a number in the form  YYYYQX. ',
	CY_QUARTER_OFFSET NUMBER(38,0),
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
    CONSTRAINT PK_T_DIM_CAL_QUARTER PRIMARY KEY (CY_QUARTER) NOT ENFORCED
)COMMENT='This dimension contains the quarter period of the calendar year.'
;