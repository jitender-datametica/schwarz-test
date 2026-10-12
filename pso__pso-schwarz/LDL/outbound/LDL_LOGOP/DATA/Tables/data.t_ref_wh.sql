/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          data
DB table/view:      t_ref_wh
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-09-24      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_ref_wh for warehouse list
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_ref_wh (
client_id INTEGER NOT NULL OPTIONS(description='Client ID'),
wh_id INTEGER NOT NULL OPTIONS(description='Warehouse number'),
wh_desc STRING(50) OPTIONS(description='Warehouse name'),
parent_wh_id INTEGER OPTIONS(description='Parent warehouse number'),
parent_wh_desc STRING(50) OPTIONS(description='Parent warehouse name'),
dat_opening DATE OPTIONS(description='Date of opening'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO code'),
country_desc STRING(35) OPTIONS(description='Country name'),
country_desc_gb STRING(35) OPTIONS(description='Country name in English'),
aspect_id INTEGER OPTIONS(description='Aspect ID (1 = BGES, 2 = VGES)'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_src STRING(50) OPTIONS(description='DWH source'),
PRIMARY KEY (client_id, wh_id) NOT ENFORCED
) OPTIONS(description='Warehouse master data');