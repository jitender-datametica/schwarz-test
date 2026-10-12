/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          p_lew_process_ac
DB table/view:      v_etl_context_orga_area_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-05      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    View for AI Core Loader
----------------------------------------------------------------------------------------------------
*/
-- Nachbildung von ldl_production_clone_ndv_d.p_lew_process_ac.v_etl_context_orga_area_2


CREATE OR REPLACE VIEW ldl_logop_p_lew_process_ac.v_etl_context_orga_area_2 (client_id OPTIONS(description='Client ID'),
country_cd OPTIONS(description='Country_2 code'), area_cd OPTIONS(description='Area code'), area_grp_type
OPTIONS(description='Area group type'), cluster_type OPTIONS(description='Cluster type'), dwh_created
OPTIONS(description='DWH creation timestamp'), dwh_src OPTIONS(description='DWH source'))
OPTIONS(DESCRIPTION = `VIEW THAT IS NEEDED FOR THE AB INITIO CORE LOADER (BASED ON T_ETL_CONTEXT_ORGA_AREA_2)`) AS SELECT
 *
FROM ldl_logop_p_lew_process.t_etl_context_orga_area_2;