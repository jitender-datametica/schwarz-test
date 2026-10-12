/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          data
DB table/view:      t_lu_forklift_exccd_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-12-01      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table for FE lookup for exception code in SAP EWM forklift
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lu_forklift_exccd_1 (
exc_cd STRING(10) NOT NULL OPTIONS(description='Exception code'),
exc_desc STRING(100) NOT NULL OPTIONS(description='Exception description'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_src STRING(50) OPTIONS(description='DWH source'),
PRIMARY KEY (exc_cd) NOT ENFORCED
) OPTIONS(description='FE lookup for exception code');