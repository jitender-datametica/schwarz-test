CREATE TABLE CORE.T_DIM_CAL_DAY_OF_WEEK_1 (
	DAY_OF_WEEK NUMBER(38,0) NOT NULL COMMENT 'The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.',
	DAY_OF_WEEK_SHORT_NAME VARCHAR(100) NOT NULL COMMENT 'The abbreviation for the weekday in group language, i.e. in German, ',
	DAY_OF_WEEK_SHORT_NAME_DE VARCHAR(100) COMMENT 'The abbreviation for the weekday in German, ',
	DAY_OF_WEEK_SHORT_NAME_EN VARCHAR(100) COMMENT 'The abbreviation for the weekday in English.',
	DAY_OF_WEEK_NAME VARCHAR(100) NOT NULL COMMENT 'The full name for day of the week in group language, i.e. in German.',
	DAY_OF_WEEK_NAME_DE VARCHAR(100) COMMENT 'The full name for day of the week in German.',
	DAY_OF_WEEK_NAME_EN VARCHAR(100) COMMENT 'The full name for day of the week in English. ',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
    CONSTRAINT PK_T_DIM_CAL_DAY_OF_WEEK PRIMARY KEY (DAY_OF_WEEK) NOT ENFORCED
)COMMENT='This minor dimension defines the seven days of the week, i.e. Monday, Tuesday, Wednesday, ...'
;