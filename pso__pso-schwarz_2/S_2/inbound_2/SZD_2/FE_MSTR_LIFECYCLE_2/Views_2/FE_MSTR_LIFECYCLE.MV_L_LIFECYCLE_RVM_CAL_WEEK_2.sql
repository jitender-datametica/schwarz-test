CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_CAL_WEEK_2 
AS SELECT 
cy_week
,week_of_year  
,cy_week_begin_week_part
,cy_week_end_week_part
,cy_week_begin_dt
,cy_week_end_dt  
,cy_week_week_part_cnt 
,cy_week_prev_1w  
,CONCAT(YEAR(DATEADD(week, -2, CY_WEEK_BEGIN_DT)) , weekofyear(DATEADD(week, -2, CY_WEEK_BEGIN_DT))) AS cy_week_prev_2w
,CONCAT(YEAR(DATEADD(week, -3, CY_WEEK_BEGIN_DT)) , weekofyear(DATEADD(week, -3, CY_WEEK_BEGIN_DT))) AS cy_week_prev_3w
,CONCAT(YEAR(DATEADD(week, -4, CY_WEEK_BEGIN_DT)) , weekofyear(DATEADD(week, -4, CY_WEEK_BEGIN_DT))) AS cy_week_prev_4w
,cy_week_prev_1y  
,cy_week_prev_2y  
,cy_week_prev_3y  
,cy_week_prev_4y  
,cy_week_prev_5y  
,IFF( DATEADD(week, -1, DATEADD(day, 1, last_day(CURRENT_DATE, week))) = CURRENT_DATE OR DATEADD(week, -1, DATEADD(day, 2, last_day(CURRENT_DATE, week))) = CURRENT_DATE , cy_week_offset - 1, cy_week_offset) AS cy_week_offset
,cy_week_short_name
,cy_week_name
,dwh_src_file_name
,dwh_created_tmsp
 dwh_updated_tmsp
FROM 
core.t_dim_cal_week_2
WHERE
 cy_week <= IFF(length(weekofyear(CURRENT_DATE)) =1 
,CONCAT(year(CURRENT_DATE)
,'0',weekofyear(CURRENT_DATE))
,CONCAT(year(CURRENT_DATE),weekofyear(CURRENT_DATE)))
ORDER BY cy_week DESC;
