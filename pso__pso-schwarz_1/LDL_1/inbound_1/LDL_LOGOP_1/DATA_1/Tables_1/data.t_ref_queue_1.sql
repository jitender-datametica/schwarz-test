/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          data
DB table/view:      t_ref_queue_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-10-26      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_ref_queue_1 for queue list
----------------------------------------------------------------------------------------------------
*/
CREATE TABLE DATA.t_ref_queue_1 (
    QUEUE VARCHAR(20) COMMENT 'Queue',
    wh_area VARCHAR(20) COMMENT 'Warehouse area',
    movement_type VARCHAR(40) COMMENT 'Type of movement of palletes',
    dwh_created TIMESTAMP COMMENT 'DWH creation timestamp',
    dwh_src VARCHAR(50) COMMENT 'DWH source',
    PRIMARY KEY (QUEUE)
) COMMENT = 'Queue master data'
;
