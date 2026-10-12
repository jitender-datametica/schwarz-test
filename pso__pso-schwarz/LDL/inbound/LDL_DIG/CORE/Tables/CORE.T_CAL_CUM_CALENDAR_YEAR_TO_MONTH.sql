CREATE TABLE CORE.T_CAL_CUM_CALENDAR_YEAR_TO_MONTH (
	CY_MONTH NUMBER(38,0) NOT NULL COMMENT 'The calendar month for which the year-to-month interval is defined.',
	INCL_CY_MONTH NUMBER(38,0) NOT NULL COMMENT 'The calendar month that needs to be included in the year-to-month interval.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'
)COMMENT='This table relates a month to all months that form the year-to-month interval of this month. E.g. for May 2019 this is January, February, March, April and May 2019.'
;