CREATE TABLE CORE.T_DIM_CAL_MONTH_OF_YEAR_1 (
	MONTH_OF_YEAR NUMBER(38,0) NOT NULL COMMENT 'The month of the calendar_1 year as a number using the convention January = 1 ... December = 12.',
	MONTH_OF_BUS_YEAR NUMBER(38,0) NOT NULL COMMENT 'The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. ',
	MONTH_OF_YEAR_SHORT_NAME VARCHAR(100) NOT NULL COMMENT 'The short name / abbreviation for month of the year in group language, i.e. in German.',
	MONTH_OF_YEAR_SHORT_NAME_DE VARCHAR(100) COMMENT 'The short name / abbreviation for month of the year in German.',
	MONTH_OF_YEAR_SHORT_NAME_EN VARCHAR(100) COMMENT 'The short name / abbreviation for month of the year in English.',
	MONTH_OF_YEAR_NAME VARCHAR(100) NOT NULL COMMENT 'The full name for the month of the year in group language, i.e. in German.',
	MONTH_OF_YEAR_NAME_DE VARCHAR(100) COMMENT 'The full name for the month of the year in German.',
	MONTH_OF_YEAR_NAME_EN VARCHAR(100) COMMENT 'The full name for the month of the year in English.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
     CONSTRAINT PK_T_DIM_CAL_MONTH_OF_YEAR PRIMARY KEY (MONTH_OF_YEAR) NOT ENFORCED
)COMMENT='This minor dimension contains the names of the twelve months of the year. (January, February, ..., December)'
;