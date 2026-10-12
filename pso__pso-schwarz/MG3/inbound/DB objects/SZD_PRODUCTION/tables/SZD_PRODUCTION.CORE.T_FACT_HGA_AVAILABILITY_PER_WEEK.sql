create or replace TABLE SZD_PRODUCTION.CORE.T_FACT_HGA_AVAILABILITY_PER_WEEK (
	HGA_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
	CY_WEEK NUMBER(38,0) NOT NULL COMMENT 'The number to which this week belongs, in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar year. Week 1 is the first week in the calendar year containing at least 4 days.',
	WEEKLY_AVAIL_PCT NUMBER(38,5) NOT NULL COMMENT 'The time duration in seconds during which the machine is functioning',
	NO_SALE_WEEKLY_VAL NUMBER(38,5) NOT NULL COMMENT 'The computed weekly value where there was no sale for more than 6 hours between consecutive sales',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_FACT_HGA_AVAILABILITY_PER_WEEK primary key (HGA_SID, CY_WEEK)
)COMMENT='Transactional fact capturing the uptime in seconds per week of hot beverage machines located in stores'
;