/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          p_lew_process_ac
DB table/view:      v_agc_aggregate_core_dependency_1 
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-10      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    View for AI Core Loader
----------------------------------------------------------------------------------------------------
*/
-- Nachbildung von ldl_production_clone_ndv_d.p_lew_process_ac.v_agc_aggregate_core_dependency_1
CREATE OR REPLACE VIEW p_lew_process_ac.v_agc_aggregate_core_dependency_1 (
    last_updated,
    core_table_name,
    aggregate_name
) COMMENT = 'View that is needed for the Ab Initio Core Loader (based on t_agc_aggregate_core_dependency_1)'
AS
SELECT
    last_updated
    ,core_table_name
    ,aggregate_name
FROM p_lew_process.t_agc_aggregate_core_dependency_1
;
