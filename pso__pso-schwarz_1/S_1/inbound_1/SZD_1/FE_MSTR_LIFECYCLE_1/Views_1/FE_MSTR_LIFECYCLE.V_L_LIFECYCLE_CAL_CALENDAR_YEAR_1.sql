CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.V_L_LIFECYCLE_CAL_CALENDAR_YEAR_1 
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
,cy_offset
,dwh_src_file_name
,dwh_created_tmsp
 dwh_updated_tmsp  
FROM 
CORE.T_DIM_CAL_CALENDAR_YEAR_1
;