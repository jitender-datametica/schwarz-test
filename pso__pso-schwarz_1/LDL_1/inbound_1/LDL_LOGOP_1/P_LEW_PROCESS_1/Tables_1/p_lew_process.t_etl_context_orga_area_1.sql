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
CREATE TABLE p_lew_process.t_etl_context_orga_area_1 (
    client_id NUMBER(2,0) NOT NULL COMMENT 'Client ID',
	country_cd VARCHAR(3) COMMENT 'Country_1 code',
	area_cd VARCHAR(20) COMMENT 'Area code',
	area_grp_type VARCHAR(20) COMMENT 'Area group type',
	cluster_type VARCHAR(20) COMMENT 'Cluster type',
    dwh_created TIMESTAMP COMMENT 'DWH creation timestamp',
    dwh_src VARCHAR(50) COMMENT 'DWH source'
) COMMENT = 'Table that is needed for the Ab Initio Core Loader'
;
