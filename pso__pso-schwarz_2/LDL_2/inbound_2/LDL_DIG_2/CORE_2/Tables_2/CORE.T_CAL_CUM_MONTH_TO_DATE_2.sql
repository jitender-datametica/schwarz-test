CREATE TABLE CORE.T_CAL_CUM_MONTH_TO_DATE_2 (
	CAL_DT DATE NOT NULL COMMENT 'The date for which the year-to-date interval is defined.',
	INCL_CAL_DT DATE NOT NULL COMMENT 'The date that needs to be included in the year-to-date interval',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'
)COMMENT='This table relates a calendar_2 date to all dates that form the month-to-date interval for this date. E.g. for February 15th 2019 this is all dates from February 1st 2019 to February 15th, inclusively.'
;