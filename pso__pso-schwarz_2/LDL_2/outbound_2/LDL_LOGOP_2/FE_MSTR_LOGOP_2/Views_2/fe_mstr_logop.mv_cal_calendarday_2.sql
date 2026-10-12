/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_cal_calendarday_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-02      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view mv_cal_calendarday_2 for calendar_2 dates
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_logop_fe_mstr_logop.mv_cal_calendarday_2 AS SELECT *
FROM ldl_logop_data.t_cal_calendarday_2;