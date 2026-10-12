create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_CAL_CUM_CALENDAR_YEAR_TO_HALF_YEAR_1(
	CAL_HALF_YEAR COMMENT 'The calendar_1 half year for which the calendar_1-year-to-half-year interval is defined.',
	INCL_CAL_HALF_YEAR COMMENT 'The calendar_1 half year that needs to be included in the calendar_1-year-to-half-year interval.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.'
) COMMENT='This table relates a calendar_1 half year to all calendar_1 half years that form the calendar_1-half-year-to-year interval of this business half year. E.g. for the20211 this is 20211 and 20212.'
 as SELECT
main.cal_half_year AS cal_half_year
,main.incl_cal_half_year AS incl_cal_half_year
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_CALENDAR_YEAR_TO_HALF_YEAR_1 main;