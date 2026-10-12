/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_lu_forklift_rsrctype_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-12-01      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    FE lookup view for resource type in SAP EWM forklift
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_forklift_rsrctype_2 (rsrc_type OPTIONS(description='Resource type'),
dwh_created OPTIONS(description='DWH creation timestamp'), dwh_src OPTIONS(description='DWH source'))
OPTIONS(DESCRIPTION = `DISTINCT LOOKUP VALUES FOR RESOURCE TYPE (BASED ON T_LU_FORKLIFT_RSRCTYPE_2)`) AS SELECT rsrc_type
 ,
 MAX(dwh_created) AS dwh_created,
 MAX(dwh_src) AS dwh_src
FROM ldl_logop_data.t_lu_forklift_rsrctype_2
GROUP BY rsrc_type;