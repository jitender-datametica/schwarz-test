/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_ref_queue_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-10-26      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view mv_ref_queue_1 for queue list
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_logop_fe_mstr_logop.mv_ref_queue_1 AS SELECT *
FROM ldl_logop_data.t_ref_queue_1;