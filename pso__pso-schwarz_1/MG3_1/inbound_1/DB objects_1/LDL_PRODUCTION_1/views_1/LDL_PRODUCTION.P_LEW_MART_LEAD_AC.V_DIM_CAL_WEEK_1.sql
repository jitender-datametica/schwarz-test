create or replace view LDL_PRODUCTION.P_LEW_MART_LEAD_AC.V_DIM_CAL_WEEK_1(
	CY_WEEK,
	WEEK_OF_YEAR,
	CY_WEEK_BEGIN_WEEK_PART,
	CY_WEEK_END_WEEK_PART,
	CY_WEEK_BEGIN_DT,
	CY_WEEK_END_DT,
	CY_WEEK_WEEK_PART_CNT,
	CY_WEEK_PREV_1W,
	CY_WEEK_PREV_1Y,
	CY_WEEK_PREV_2Y,
	CY_WEEK_PREV_3Y,
	CY_WEEK_PREV_4Y,
	CY_WEEK_PREV_5Y,
	CY_WEEK_OFFSET,
	CY_WEEK_SHORT_NAME,
	CY_WEEK_NAME,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   (
        SELECT      CalWk.cy_week                    AS cy_week,
   CalWk.week_of_year               AS week_of_year,
   CalWk.cy_week_begin_week_part    AS cy_week_begin_week_part,
   CalWk.cy_week_end_week_part      AS cy_week_end_week_part,
   CalWk.cy_week_begin_dt           AS cy_week_begin_dt,
   CalWk.cy_week_end_dt             AS cy_week_end_dt,
   CalWk.cy_week_week_part_cnt      AS cy_week_week_part_cnt,
   CalWk.cy_week_prev_1w            AS cy_week_prev_1w,
   CalWk.cy_week_prev_1y            AS cy_week_prev_1y,
   CalWk.cy_week_prev_2y            AS cy_week_prev_2y,
   CalWk.cy_week_prev_3y            AS cy_week_prev_3y,
   CalWk.cy_week_prev_4y            AS cy_week_prev_4y,
   CalWk.cy_week_prev_5y            AS cy_week_prev_5y,
   CalWk.cy_week_offset             AS cy_week_offset,
   CalWk.cy_week_short_name         AS cy_week_short_name,
   CalWk.cy_week_name               AS cy_week_name,
   CalWk.dwh_load_id                AS dwh_load_id,
   CalWk.dwh_created                AS dwh_created,
   CalWk.dwh_updated                AS dwh_updated

FROM p_lew_mart_lead.v_dim_cal_week_1        AS CalWk
   );