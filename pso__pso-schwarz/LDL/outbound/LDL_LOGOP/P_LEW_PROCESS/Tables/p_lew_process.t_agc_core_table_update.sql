/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          p_lew_process
DB table/view:      t_agc_core_table_update  
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
-- Nachbildung von ldl_production_clone_ndv_d.p_lew_process.t_agc_core_table_update


CREATE TABLE IF NOT EXISTS ldl_logop_p_lew_process.t_agc_core_table_update (
core_table_name STRING(100) COLLATE 'und:ci' NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
dwh_cal_dt DATE NOT NULL,
recalc_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
create_timestamp DATETIME,
dwh_load_id BIGNUMERIC(38,0),
PRIMARY KEY (client_id, dwh_cal_dt, recalc_fg) NOT ENFORCED
) OPTIONS(description='Table that is needed for the Ab Initio Core Loader');