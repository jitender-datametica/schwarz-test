create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_CAL_DATE_ADJUSTED_RELATIONSHIP_1 (
	CAL_DT DATE NOT NULL COMMENT 'The day being mapped back to previous (business) years, represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
	CAL_DT_ADJUST_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'A code for the rule, which defines, how a calendar_1 date is related to its equivalent day(s) in the previous year(s).',
	BUS_YEAR_DIFF NUMBER(38,0) NOT NULL COMMENT 'The difference in years between the current business year and the business year we are mapping back to. I.e. 1 for the previous year, 2 for 2 years ago etc.',
	REL_CAL_DT DATE NOT NULL COMMENT 'The equivalent calendar_1 date n year(s) in the past.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_CAL_DATE_ADJUSTED_RELATIONSHIP primary key (CAL_DT, CAL_DT_ADJUST_TYPE_CD, BUS_YEAR_DIFF, REL_CAL_DT)
)COMMENT='This table maps a calendar_1 date to its equivalent day(s) in the previous business years, maintaining the same weekday. In case of leap years this is a many-to-many relation. As this mapping can be done in various ways, the adjustment type defines the rule, how the mapping is done. One rule is used on month-level. E.g. 28th of February 2021 is mapped to both 28th and 29 of February 2020. Another rule maps the 28 of February 2021 to both March 1st and March 2nd of 2019, so that the integrity of business years is maintained.'
;