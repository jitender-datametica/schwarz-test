CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_day_of_week_1 (day_of_week
OPTIONS(description='The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.'),
day_of_week_short_name OPTIONS(description='The abbreviation for the weekday in group language, i.e. in German, '),
day_of_week_short_name_de OPTIONS(description='The abbreviation for the weekday in German, '), day_of_week_short_name_en
OPTIONS(description='The abbreviation for the weekday in English'), day_of_week_name
OPTIONS(description='The full name for day of the week in group language, i.e. in German.'), day_of_week_name_de
OPTIONS(description='The full name for day of the week in German.'), day_of_week_name_en
OPTIONS(description='The full name for day of the week in English'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION DEFINES THE SEVEN DAYS OF THE WEEK, I.E. MONDAY, TUESDAY, WEDNESDAY, ...`)
AS SELECT day_of_week,
 day_of_week_short_name,
 day_of_week_short_name_de,
 day_of_week_short_name_en,
 day_of_week_name,
 day_of_week_name_de,
 day_of_week_name_en,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_core_dim.t_dim_day_of_week_1 AS MAIN;