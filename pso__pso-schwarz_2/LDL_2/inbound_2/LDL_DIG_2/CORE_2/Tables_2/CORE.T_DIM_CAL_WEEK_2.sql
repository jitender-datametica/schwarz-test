CREATE TABLE CORE.T_DIM_CAL_WEEK_2 (
	CY_WEEK NUMBER(38,0) NOT NULL COMMENT 'The week as a number of the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_2 year. Week 1 is the first week in the calendar_2 year containing at least 4 days.',
	WEEK_OF_YEAR NUMBER(38,0) NOT NULL COMMENT 'The number of the week within the calendar_2 year, i.e. a number between 1 and 53. Week 1 is the first week in the calendar_2 year containing at least 4 days, therefore the first week containing a Thursday.',
	CY_WEEK_BEGIN_WEEK_PART NUMBER(38,0) NOT NULL COMMENT 'The first partial week (inclusive) of the week as a number in the form YYYYWWn. Eg. 2020531.',
	CY_WEEK_END_WEEK_PART NUMBER(38,0) NOT NULL COMMENT 'The last partial week (inclusive) of the week as a number in the form YYYYWWn. Eg. 2020532. If the week does not span two months, this is the same as cy_week_begin_week_part.',
	CY_WEEK_BEGIN_DT DATE NOT NULL COMMENT 'The first day of the week - i.e. the Monday - in the form YYYY-MM_2-DD. Eg. 2020-12-28.',
	CY_WEEK_END_DT DATE NOT NULL COMMENT 'The last day of the week - i.e. the Sunday - in the form YYYY-MM_2-DD. Eg. 2021-01-03. ',
	CY_WEEK_WEEK_PART_CNT NUMBER(38,0) COMMENT 'The number of partial weeks in this week, i.e. 1 or 2.',
	CY_WEEK_PREV_1W NUMBER(38,0) NOT NULL COMMENT 'The previous week as a number in the form YYYYWW. Eg. 202052. ',
	CY_WEEK_PREV_1Y NUMBER(38,0) NOT NULL COMMENT 'The week 1 year (= 384 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.',
	CY_WEEK_PREV_2Y NUMBER(38,0) NOT NULL COMMENT 'The week 2 years (= 728 days = 104 weeks) ago as a number in the form YYYYWW. Eg. 201901. ',
	CY_WEEK_PREV_3Y NUMBER(38,0) NOT NULL COMMENT 'The week 3 years (= 1092 days = 156 weeks) ago as a number in the form YYYYWW. Eg. 201801.',
	CY_WEEK_PREV_4Y NUMBER(38,0) NOT NULL COMMENT 'The week 4 years (= 1456 days = 208 weeks) ago as a number in the form YYYYWW. Eg. 201701.',
	CY_WEEK_PREV_5Y NUMBER(38,0) NOT NULL COMMENT 'The week 5 years (= 1820 days = 260 weeks) ago as a number in the form YYYYWW. Eg. 201601.',
	CY_WEEK_OFFSET NUMBER(38,0) COMMENT 'The difference in weeks between this week and the current week. So if current week is 202053 then the offset is 0 for 202053, -1 for 202052 and +1 for 202101. ',
	CY_WEEK_SHORT_NAME VARCHAR(100) COMMENT 'A short version of the name of the week in the format \"KW nn\" with nn being the week of the year.',
	CY_WEEK_NAME VARCHAR(100) COMMENT 'The name of the week in the format \"YYYY KW nn\" with YYYY being the year and nn being the week of the year.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
    CONSTRAINT PK_T_DIM_CAL_WEEK PRIMARY KEY (CY_WEEK) NOT ENFORCED
)COMMENT='Calendar_2 weeks. A week may span two months or two years. A week is considered part of the year, into which most of its days fall.'
;