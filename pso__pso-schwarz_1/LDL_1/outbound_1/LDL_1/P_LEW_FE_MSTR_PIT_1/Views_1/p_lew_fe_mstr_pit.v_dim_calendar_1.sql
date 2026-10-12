/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_CALENDAR
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar_1 Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 ANDreas Kurz	   	Initial version
#  2.0	2022-07-16 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  2.2  2025-01-15 Nikolai Toknov	Drop part of columns
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_CALENDAR_1');

DESC TABLE P_LEW_MART_PIT.T_DIM_CALENDAR_1;

DROP VIEW LDL.P_LEW_MART_PIT.V_DIM_CALENDAR_1

*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_DIM_CALENDAR_1
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_calendar_1 OPTIONS(DESCRIPTION = `VIEW TABLE PIT CALENDAR_1`) AS SELECT
 day_dt,
 day_of_week_id,
 day_of_week_iso_id,
 week_id,
 week_iso_id,
 month_id,
 month_nbr,
 year_id,
 year_iso_id,
 fiscalyear_id,
 moving_day_start_nbr,
 mov_day_nbr_per_year,
 mov_day_nbr_per_month,
 fiscal_year_start_fg,
 fiscal_year_end_fg,
 year_end_fg,
 year_start_fg,
 month_end_fg,
 month_start_fg,
 day_char,
 day_int,
 next_day_dt,
 prev_day_dt,
 sameday_prev_1_year_day_dt,
 sameday_prev_2_year_day_dt,
 sameday_prev_3_year_day_dt,
 sameday_prev_4_year_day_dt,
 sameday_prev_1_year_week_id,
 sameday_prev_2_year_week_id,
 sameday_prev_3_year_week_id,
 sameday_prev_4_year_week_id,
 sameday_prev_1_year_week_iso_id,
 sameday_prev_2_year_week_iso_id,
 sameday_prev_3_year_week_iso_id,
 sameday_prev_4_year_week_iso_id,
 sameday_prev_1_year_month_id,
 sameday_prev_2_year_month_id,
 sameday_prev_3_year_month_id,
 sameday_prev_4_year_month_id,
 sameday_prev_1_year_year_id,
 sameday_prev_2_year_year_id,
 sameday_prev_3_year_year_id,
 sameday_prev_4_year_year_id,
 prev_1_month_id,
 prev_3_month_id,
 prev_6_month_id,
 prev_9_month_id,
 prev_12_month_id,
 next_1_month_id,
 prev_1_year_id,
 prev_2_year_id,
 prev_3_year_id,
 prev_4_year_id,
 next_1_year_id,
 prev_1_week_iso_id,
 prev_2_week_iso_id,
 prev_3_week_iso_id,
 prev_4_week_iso_id,
 prev_5_week_iso_id,
 prev_6_week_iso_id,
 prev_7_week_iso_id,
 prev_8_week_iso_id,
 prev_9_week_iso_id,
 prev_1_year_week_iso_id,
 next_1_week_iso_id,
 leap_year_fg,
 prev_month_year_id,
 next_month_year_id,
 moving_day_from_start,
 moving_week_from_start,
 moving_week_iso_from_start,
 moving_month_from_start,
 moving_year_from_start,
 week_start_day_dt,
 week_end_day_dt,
 week_nbr,
 week_iso_nbr,
 week_iso_sdesc,
 week_iso_ldesc,
 month_sdesc,
 month_display_name,
 month_display_name_sdesc,
 month_ldesc,
 month_start_day_dt,
 month_end_day_dt,
 year_start_day_dt,
 year_end_day_dt,
 nbr_of_days_per_week,
 nbr_of_days_per_month,
 nbr_of_days_per_year,
 day_of_week_sdesc,
 day_of_week_ldesc,
 prev_day_of_week,
 next_day_of_week,
 splitted_week_fg,
 splitted_week_part1_nbr_of_days,
 splitted_week_part2_nbr_of_days,
 annotation,
 IF(DATE(CURRENT_DATE) = day_dt, 1, 0) AS current_day_fg,
 IF(EXTRACT(ISOYEAR FROM DATE(CURRENT_DATE)) * 100 + EXTRACT(ISOWEEK FROM DATE(CURRENT_DATE)) = week_iso_id, 1, 0) AS
 current_week_fg,
 IF(EXTRACT(YEAR FROM DATE(CURRENT_DATE)) * 100 + EXTRACT(MONTH FROM DATE(CURRENT_DATE)) = month_id, 1, 0) AS
 current_month_fg,
 IF(EXTRACT(YEAR FROM DATE(CURRENT_DATE)) = year_id, 1, 0) AS current_year_fg,
  DATE_DIFF(DATE(CURRENT_DATE), day_dt, DAY) * - 1 AS mov_day_start_from_current,
  DATE_DIFF(DATE(CURRENT_DATE), day_dt, WEEK) * - 1 AS mov_week_start_from_current,
  DATE_DIFF(DATE(CURRENT_DATE), day_dt, MONTH) * - 1 AS mov_month_start_from_current,
 dwh_created_ts
FROM ldl_p_lew_mart_pit.t_dim_calendar_1 AS DT;