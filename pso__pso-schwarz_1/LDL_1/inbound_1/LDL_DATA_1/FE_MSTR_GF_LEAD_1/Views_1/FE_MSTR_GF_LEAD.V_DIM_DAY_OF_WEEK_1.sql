CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_DAY_OF_WEEK_1 (
day_of_week COMMENT 'The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.'
,day_of_week_short_name COMMENT 'The abbreviation for the weekday in group language, i.e. in German, '
,day_of_week_short_name_de COMMENT 'The abbreviation for the weekday in German, '
,day_of_week_short_name_en COMMENT 'The abbreviation for the weekday in English'
,day_of_week_name COMMENT 'The full name for day of the week in group language, i.e. in German.'
,day_of_week_name_de COMMENT 'The full name for day of the week in German.'
,day_of_week_name_en COMMENT 'The full name for day of the week in English'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
) COMMENT = 'This minor dimension defines the seven days of the week, i.e. Monday, Tuesday, Wednesday, ...' AS SELECT
main.day_of_week AS day_of_week
,main.day_of_week_short_name AS day_of_week_short_name
,main.day_of_week_short_name_de AS day_of_week_short_name_de
,main.day_of_week_short_name_en AS day_of_week_short_name_en
,main.day_of_week_name AS day_of_week_name
,main.day_of_week_name_de AS day_of_week_name_de
,main.day_of_week_name_en AS day_of_week_name_en
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_DIM.T_DIM_DAY_OF_WEEK_1 main;