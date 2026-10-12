/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_ref_queue_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-10-26      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view mv_ref_queue_2 for queue list
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_ref_queue_2 (
    QUEUE COMMENT 'Queue'
    ,wh_area COMMENT 'Warehouse area'
    ,movement_type COMMENT 'Type of movement of palletes'
    ,dwh_created COMMENT 'DWH creation timestamp'
    ,dwh_src COMMENT 'DWH source'
) COMMENT = 'Warehouse master data - materialized view based on t_ref_queue_2'
AS 
SELECT
    QUEUE
    ,wh_area
    ,movement_type
    ,dwh_created
    ,dwh_src
FROM DATA.t_ref_queue_2
;
