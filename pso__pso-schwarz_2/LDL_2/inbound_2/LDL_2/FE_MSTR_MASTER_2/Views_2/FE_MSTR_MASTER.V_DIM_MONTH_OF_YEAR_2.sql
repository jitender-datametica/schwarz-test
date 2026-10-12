CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_DIM_MONTH_OF_YEAR_2 (
month_of_year COMMENT 'The month of the calendar_2 year as a number using the convention January = 1 ... December = 12.'
,month_of_bus_year COMMENT 'The month of the business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '
,month_of_year_short_name COMMENT 'The short name / abbreviation for month of the year in group language, i.e. in German.'
,month_of_year_short_name_de COMMENT 'The short name / abbreviation for month of the year in German.'
,month_of_year_short_name_en COMMENT 'The short name / abbreviation for month of the year in English'
,month_of_year_name COMMENT 'The full name for the month of the year in group language, i.e. in German.'
,month_of_year_name_de COMMENT 'The full name for the month of the year in German.'
,month_of_year_name_en COMMENT 'The full name for the month of the year in English.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
) COMMENT = 'This minor dimension contains the names of the twelve months of the year. (January, February, ..., December)' AS SELECT
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
FROM CORE_DIM.T_DIM_MONTH_OF_YEAR_2 main;