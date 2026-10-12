/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          data
DB table/view:      t_ref_queue_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-10-26      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_ref_queue_2 for queue list
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_ref_queue_2 (
queue STRING(20) NOT NULL OPTIONS(description='Queue'),
wh_area STRING(20) OPTIONS(description='Warehouse area'),
movement_type STRING(40) OPTIONS(description='Type of movement of palletes'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_src STRING(50) OPTIONS(description='DWH source'),
PRIMARY KEY (queue) NOT ENFORCED
) OPTIONS(description='Queue master data');