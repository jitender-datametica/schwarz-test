/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          data
DB table/view:      t_lu_forklift_rsrctype_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-12-01      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table for FE lookup for resource type in SAP EWM forklift
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lu_forklift_rsrctype_1 (
rsrc_type STRING(20) NOT NULL OPTIONS(description='Resource type'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_src STRING(50) OPTIONS(description='DWH source'),
PRIMARY KEY (rsrc_type) NOT ENFORCED
) OPTIONS(description='FE lookup for resource type');