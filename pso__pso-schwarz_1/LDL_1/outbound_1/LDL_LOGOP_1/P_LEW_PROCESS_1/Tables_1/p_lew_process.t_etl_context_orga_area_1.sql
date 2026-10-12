/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          p_lew_process
DB table/view:      t_etl_context_orga_area_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-05      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table for AI Core Loader
----------------------------------------------------------------------------------------------------
*/
-- Nachbildung von ldl_production_clone_ndv_d.p_lew_process_ac.v_etl_context_orga_area_1


CREATE TABLE IF NOT EXISTS ldl_logop_p_lew_process.t_etl_context_orga_area_1 (
client_id INTEGER NOT NULL OPTIONS(description='Client ID'),
country_cd STRING(3) OPTIONS(description='Country_1 code'),
area_cd STRING(20) OPTIONS(description='Area code'),
area_grp_type STRING(20) OPTIONS(description='Area group type'),
cluster_type STRING(20) OPTIONS(description='Cluster type'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_src STRING(50) OPTIONS(description='DWH source')
) OPTIONS(description='Table that is needed for the Ab Initio Core Loader');