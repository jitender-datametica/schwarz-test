/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          data
DB table/view:      t_ref_timehour
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2022-01-27      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table for FE dimension list for time hours in various reports
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_ref_time_hour (
hr_id INTEGER NOT NULL OPTIONS(description='ID for time hour'),
hr_h INTEGER NOT NULL OPTIONS(description='Time hour in format h or hh without leading zeros as number'),
hr_hh STRING(2) NOT NULL OPTIONS(description='Time hour in format hh as string'),
hr_mm STRING(5) NOT NULL OPTIONS(description='Time hour in format hh:mm as string'),
hr_ss TIME NOT NULL OPTIONS(description='Time hour in format hh:mm:ss as time'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_src STRING(50) OPTIONS(description='DWH source'),
PRIMARY KEY (hr_id) NOT ENFORCED
) OPTIONS(description='FE dimension list for time hours');