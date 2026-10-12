/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_ref_timehour
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2022-01-27      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    FE view v_ref_timehour for hour list
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_ref_time_hour_2 (hr_id OPTIONS(description='ID for time hour'), hr_h
OPTIONS(description='Time hour in format h or hh without leading zeros as number'), hr_hh
OPTIONS(description='Time hour in format hh as string'), hr_mm
OPTIONS(description='Time hour in format hh:mm_2 as string'), hr_ss
OPTIONS(description='Time hour in format hh:mm_2:ss as time'), dwh_created OPTIONS(description='DWH creation timestamp'),
dwh_src OPTIONS(description='DWH source'))
OPTIONS(DESCRIPTION = `FE DIMENSION LIST FOR TIME HOURS - VIEW BASED ON T_REF_TIMEHOUR`) AS SELECT *
FROM ldl_logop_data.t_ref_time_hour_2;