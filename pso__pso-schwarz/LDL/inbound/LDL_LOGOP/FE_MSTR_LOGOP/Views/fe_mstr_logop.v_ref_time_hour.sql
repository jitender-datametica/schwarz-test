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
CREATE OR REPLACE VIEW fe_mstr_logop.v_ref_time_hour (
    hr_id COMMENT 'ID for time hour'
    ,hr_h COMMENT 'Time hour in format h or hh without leading zeros as number'
    ,hr_hh COMMENT 'Time hour in format hh as string'
    ,hr_mm COMMENT 'Time hour in format hh:mm as string'
    ,hr_ss COMMENT 'Time hour in format hh:mm:ss as time'
    ,dwh_created COMMENT 'DWH creation timestamp'
    ,dwh_src COMMENT 'DWH source'
) COMMENT = 'FE dimension list for time hours - view based on t_ref_timehour'
AS
SELECT
    hr_id
    ,hr_h
    ,hr_hh
    ,hr_mm
    ,hr_ss
    ,dwh_created
    ,dwh_src
FROM DATA.t_ref_time_hour
;
