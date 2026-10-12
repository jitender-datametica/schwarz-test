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
CREATE TABLE DATA.t_lu_forklift_exccd_1 (
    exc_cd VARCHAR(10) NOT NULL COMMENT 'Exception code',
    exc_desc VARCHAR(100) NOT NULL COMMENT 'Exception description',
    dwh_created TIMESTAMP COMMENT 'DWH creation timestamp',
    dwh_src VARCHAR(50) COMMENT 'DWH source',
    PRIMARY KEY (exc_cd)
) COMMENT = 'FE lookup for exception code'
;
