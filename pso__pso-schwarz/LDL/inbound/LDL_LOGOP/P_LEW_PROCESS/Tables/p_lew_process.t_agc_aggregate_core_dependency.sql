/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          p_lew_process
DB table/view:      t_agc_aggregate_core_dependency 
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
-- Nachbildung von ldl_production_clone_ndv_d.p_lew_process_ac.v_agc_aggregate_core_dependency
CREATE TABLE p_lew_process.t_agc_aggregate_core_dependency (
    last_updated TIMESTAMP_NTZ,
    core_table_name VARCHAR(100),
    aggregate_name VARCHAR(100)
) COMMENT = 'Table that is needed for the Ab Initio Core Loader'
;
