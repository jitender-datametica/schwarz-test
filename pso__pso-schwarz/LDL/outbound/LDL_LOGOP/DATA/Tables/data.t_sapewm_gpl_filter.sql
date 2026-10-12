/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          data
DB table/view:      T_SAPEWM_GPL_FILTER
====================================================================================================
*/

/*
----------------------------------------------------------------------------------------------------
    Table T_SAPEWM_GPL_FILTER
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_sapewm_gpl_filter (
dest_strg_type STRING(4) OPTIONS(description='Destination Storage Type'),
queue STRING(10) OPTIONS(description='Warehouse queue'),
area_comb STRING(15) OPTIONS(description='Area Comb')
);