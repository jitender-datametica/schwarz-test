/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_lu_forklift_wharea_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-12-01      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    FE lookup view for warehouse area
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_forklift_wharea_1 (wh_area OPTIONS(description='Warehouse area'),
dwh_created OPTIONS(description='DWH creation timestamp'), dwh_src OPTIONS(description='DWH source'))
OPTIONS(DESCRIPTION = `DISTINCT LOOKUP VALUES FOR WAREHOUSE AREA`) AS SELECT wh_area,
 MAX(dwh_created) AS dwh_created,
 MAX(dwh_src) AS dwh_src
FROM ldl_logop_data.t_ref_queue_1
GROUP BY wh_area;