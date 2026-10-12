/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          data
DB table/view:      t_lu_forklift_rsrctype
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
CREATE TABLE DATA.t_lu_forklift_rsrctype (
    rsrc_type VARCHAR(20) NOT NULL COMMENT 'Resource type',
    dwh_created TIMESTAMP COMMENT 'DWH creation timestamp',
    dwh_src VARCHAR(50) COMMENT 'DWH source',
    PRIMARY KEY (rsrc_type)
) COMMENT = 'FE lookup for resource type'
;
