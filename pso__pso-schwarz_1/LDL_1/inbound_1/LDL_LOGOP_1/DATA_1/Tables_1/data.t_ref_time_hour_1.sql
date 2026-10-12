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
CREATE TABLE DATA.t_ref_time_hour_1 (
    hr_id NUMBER(2,0) NOT NULL COMMENT 'ID for time hour',
    hr_h NUMBER(2,0) NOT NULL COMMENT 'Time hour in format h or hh without leading zeros as number',
    hr_hh VARCHAR(2) NOT NULL COMMENT 'Time hour in format hh as string',
    hr_mm VARCHAR(5) NOT NULL COMMENT 'Time hour in format hh:mm_1 as string',
    hr_ss TIME NOT NULL COMMENT 'Time hour in format hh:mm_1:ss as time',
    dwh_created TIMESTAMP COMMENT 'DWH creation timestamp',
    dwh_src VARCHAR(50) COMMENT 'DWH source',
    PRIMARY KEY (hr_id)
) COMMENT = 'FE dimension list for time hours'
;
