/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          p_lew_process
DB table/view:      t_agc_core_table_update_1  
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
-- Nachbildung von ldl_production_clone_ndv_d.p_lew_process.t_agc_core_table_update_1
CREATE TABLE p_lew_process.t_agc_core_table_update_1 (
    core_table_name VARCHAR(100) NOT NULL COLLATE 'en-ci',
    client_id NUMBER(38,0) NOT NULL,
    dwh_cal_dt DATE NOT NULL,
    recalc_fg NUMBER(38,0) NOT NULL DEFAULT 0,
    create_timestamp TIMESTAMP_NTZ(9),
    dwh_load_id NUMBER(38,0),
    CONSTRAINT pk_t_agc_core_table_update PRIMARY KEY (core_table_name, client_id, dwh_cal_dt, recalc_fg)
) COMMENT = 'Table that is needed for the Ab Initio Core Loader'
;
