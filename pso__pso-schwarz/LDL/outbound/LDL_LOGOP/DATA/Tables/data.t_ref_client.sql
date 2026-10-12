/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          data
DB table/view:      t_ref_client
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-09-24      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_ref_client for client list
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_ref_client (
client_id INTEGER NOT NULL OPTIONS(description='Client ID'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO code'),
country_desc STRING(35) OPTIONS(description='Country name'),
country_desc_gb STRING(35) OPTIONS(description='Country name in English'),
aspect_id INTEGER OPTIONS(description='Aspect ID (1 = BGES, 2 = VGES)'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_src STRING(50) OPTIONS(description='DWH source'),
PRIMARY KEY (client_id) NOT ENFORCED
) OPTIONS(description='Client master data');