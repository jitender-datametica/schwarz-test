/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          p_lew_process_ac
DB table/view:      v_etl_context_orga_area_1
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
-- Nachbildung von ldl_production_clone_ndv_d.p_lew_process_ac.v_etl_context_orga_area_1
CREATE OR REPLACE VIEW p_lew_process_ac.v_etl_context_orga_area_1 (
    client_id COMMENT 'Client ID',
	country_cd COMMENT 'Country_1 code',
	area_cd COMMENT 'Area code',
	area_grp_type COMMENT 'Area group type',
	cluster_type COMMENT 'Cluster type',
    dwh_created COMMENT 'DWH creation timestamp',
    dwh_src COMMENT 'DWH source'
) COMMENT = 'View that is needed for the Ab Initio Core Loader (based on t_etl_context_orga_area_1)'
AS 
SELECT
	client_id
	,country_cd
	,area_cd
	,area_grp_type
	,cluster_type
    ,dwh_created
    ,dwh_src
FROM p_lew_process.t_etl_context_orga_area_1
;
