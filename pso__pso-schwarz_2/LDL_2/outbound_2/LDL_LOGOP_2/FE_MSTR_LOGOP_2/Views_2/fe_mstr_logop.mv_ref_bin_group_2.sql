/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_ref_bin_group_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2022-03-02      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for bin group definition and relation to storage bin
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_logop_fe_mstr_logop.mv_ref_bin_group_2 AS SELECT *
FROM ldl_logop_data.t_ref_bin_group_2;