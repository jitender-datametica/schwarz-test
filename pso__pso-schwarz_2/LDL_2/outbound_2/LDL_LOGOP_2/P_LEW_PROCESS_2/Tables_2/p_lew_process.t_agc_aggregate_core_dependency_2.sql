/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          p_lew_process
DB table/view:      t_agc_aggregate_core_dependency_2 
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-10      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table for AI Core Loader
----------------------------------------------------------------------------------------------------
*/
-- Nachbildung von ldl_production_clone_ndv_d.p_lew_process_ac.v_agc_aggregate_core_dependency_2


CREATE TABLE IF NOT EXISTS ldl_logop_p_lew_process.t_agc_aggregate_core_dependency_2 (
last_updated DATETIME,
core_table_name STRING(100),
aggregate_name STRING(100)
) OPTIONS(description='Table that is needed for the Ab Initio Core Loader');