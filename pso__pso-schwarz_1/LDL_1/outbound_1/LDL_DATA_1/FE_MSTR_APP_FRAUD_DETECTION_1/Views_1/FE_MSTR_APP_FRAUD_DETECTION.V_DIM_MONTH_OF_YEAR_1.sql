CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_month_of_year_1 (month_of_year
OPTIONS(description='The month of the calendar_1 year as a number using the convention January = 1 ... December = 12.'),
month_of_bus_year
OPTIONS(description='The month of the business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
month_of_year_short_name
OPTIONS(description='The short name / abbreviation for month of the year in group language, i.e. in German.'),
month_of_year_short_name_de OPTIONS(description='The short name / abbreviation for month of the year in German.'),
month_of_year_short_name_en OPTIONS(description='The short name / abbreviation for month of the year in English'),
month_of_year_name OPTIONS(description='The full name for the month of the year in group language, i.e. in German.'),
month_of_year_name_de OPTIONS(description='The full name for the month of the year in German.'), month_of_year_name_en
OPTIONS(description='The full name for the month of the year in English.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION CONTAINS THE NAMES OF THE TWELVE MONTHS OF THE YEAR. (JANUARY, FEBRUARY, ..., DECEMBER)`)
AS SELECT month_of_year,
 month_of_bus_year,
 month_of_year_short_name,
 month_of_year_short_name_de,
 month_of_year_short_name_en,
 month_of_year_name,
 month_of_year_name_de,
 month_of_year_name_en,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_core_dim.t_dim_month_of_year_1 AS MAIN;