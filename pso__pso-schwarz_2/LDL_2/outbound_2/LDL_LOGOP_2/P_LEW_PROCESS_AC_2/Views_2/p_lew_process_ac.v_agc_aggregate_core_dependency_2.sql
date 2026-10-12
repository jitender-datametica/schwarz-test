/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          p_lew_process_ac
DB table/view:      v_agc_aggregate_core_dependency_2 
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
-- Nachbildung von ldl_production_clone_ndv_d.p_lew_process_ac.v_agc_aggregate_core_dependency_2


CREATE OR REPLACE VIEW ldl_logop_p_lew_process_ac.v_agc_aggregate_core_dependency_2 (last_updated, core_table_name,
aggregate_name)
OPTIONS(DESCRIPTION = `VIEW THAT IS NEEDED FOR THE AB INITIO CORE LOADER (BASED ON T_AGC_AGGREGATE_CORE_DEPENDENCY_2)`) AS
SELECT *
FROM ldl_logop_p_lew_process.t_agc_aggregate_core_dependency_2;