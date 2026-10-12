create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_DAY_OF_WEEK(
	DAY_OF_WEEK COMMENT 'The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.',
	DAY_OF_WEEK_SHORT_NAME COMMENT 'The abbreviation for the weekday in group language, i.e. in German, ',
	DAY_OF_WEEK_SHORT_NAME_DE COMMENT 'The abbreviation for the weekday in German, ',
	DAY_OF_WEEK_SHORT_NAME_EN COMMENT 'The abbreviation for the weekday in English',
	DAY_OF_WEEK_NAME COMMENT 'The full name for day of the week in group language, i.e. in German.',
	DAY_OF_WEEK_NAME_DE COMMENT 'The full name for day of the week in German.',
	DAY_OF_WEEK_NAME_EN COMMENT 'The full name for day of the week in English',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.'
) COMMENT='This minor dimension defines the seven days of the week, i.e. Monday, Tuesday, Wednesday, ...'
 as SELECT
main.day_of_week AS day_of_week
,main.day_of_week_short_name AS day_of_week_short_name
,main.day_of_week_short_name_de AS day_of_week_short_name_de
,main.day_of_week_short_name_en AS day_of_week_short_name_en
,main.day_of_week_name AS day_of_week_name
,main.day_of_week_name_de AS day_of_week_name_de
,main.day_of_week_name_en AS day_of_week_name_en
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_DIM.T_DIM_DAY_OF_WEEK main;