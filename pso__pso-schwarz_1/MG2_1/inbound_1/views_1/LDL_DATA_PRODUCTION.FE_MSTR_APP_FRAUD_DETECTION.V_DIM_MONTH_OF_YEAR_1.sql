create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_DIM_MONTH_OF_YEAR_1(
	MONTH_OF_YEAR COMMENT 'The month of the calendar_1 year as a number using the convention January = 1 ... December = 12.',
	MONTH_OF_BUS_YEAR COMMENT 'The month of the business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. ',
	MONTH_OF_YEAR_SHORT_NAME COMMENT 'The short name / abbreviation for month of the year in group language, i.e. in German.',
	MONTH_OF_YEAR_SHORT_NAME_DE COMMENT 'The short name / abbreviation for month of the year in German.',
	MONTH_OF_YEAR_SHORT_NAME_EN COMMENT 'The short name / abbreviation for month of the year in English',
	MONTH_OF_YEAR_NAME COMMENT 'The full name for the month of the year in group language, i.e. in German.',
	MONTH_OF_YEAR_NAME_DE COMMENT 'The full name for the month of the year in German.',
	MONTH_OF_YEAR_NAME_EN COMMENT 'The full name for the month of the year in English.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.'
) COMMENT='This minor dimension contains the names of the twelve months of the year. (January, February, ..., December)'
 as SELECT
main.month_of_year AS month_of_year
,main.month_of_bus_year AS month_of_bus_year
,main.month_of_year_short_name AS month_of_year_short_name
,main.month_of_year_short_name_de AS month_of_year_short_name_de
,main.month_of_year_short_name_en AS month_of_year_short_name_en
,main.month_of_year_name AS month_of_year_name
,main.month_of_year_name_de AS month_of_year_name_de
,main.month_of_year_name_en AS month_of_year_name_en
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_DIM.T_DIM_MONTH_OF_YEAR_1 main;