CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_CAL_CALENDAR_YEAR_1 
AS SELECT
 cy
,cy_begin_month
,cy_end_month 
,cy_begin_week_part 
,cy_end_week_part 
,cy_begin_dt  
,cy_end_dt 
,cy_week_cnt 
,cy_week_part_cnt  
,cy_day_cnt 
,cy_prev_1y 
,cy_prev_2y 
,cy_prev_3y
,cy_prev_4y
,cy_prev_5y
,IFF(DATEADD(year, -1, DATEADD(day, 1, last_day(CURRENT_DATE, year))) = CURRENT_DATE OR DATEADD(year, -1, DATEADD(day, 2, last_day(CURRENT_DATE, year))) = CURRENT_DATE, cy_offset - 1, cy_offset) AS cy_offset
,dwh_src_file_name
,dwh_created_tmsp
 dwh_updated_tmsp  
FROM 
CORE.T_DIM_CAL_CALENDAR_YEAR_1
;