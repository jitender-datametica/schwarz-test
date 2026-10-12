/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_lu_forklift_movementtype_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-12-01      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    FE lookup view for movement type
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_forklift_movementtype_1 (movement_type
OPTIONS(description='Movement type'), dwh_created OPTIONS(description='DWH creation timestamp'), dwh_src
OPTIONS(description='DWH source'))
OPTIONS(DESCRIPTION = `DISTINCT LOOKUP VALUES FOR MOVEMENT TYPE (BASED ON MV_REF_QUEUE_1)`) AS SELECT movement_type,
 MAX(dwh_created) AS dwh_created,
 MAX(dwh_src) AS dwh_src
FROM ldl_logop_data.t_ref_queue_1
GROUP BY movement_type;