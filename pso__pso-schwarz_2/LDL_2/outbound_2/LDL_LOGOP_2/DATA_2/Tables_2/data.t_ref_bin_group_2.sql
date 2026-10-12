/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          data
DB table/view:      t_ref_bin_group_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2022-03-02      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_ref_bin_group_2 for bin group
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_ref_bin_group_2 (
bin_id INTEGER NOT NULL OPTIONS(description='Bin ID'),
strg_bin STRING(10) OPTIONS(description='Storage bin'),
bin_grp STRING(50) OPTIONS(description='Bin group'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_src STRING(50) OPTIONS(description='DWH source'),
PRIMARY KEY (bin_id) NOT ENFORCED
) OPTIONS(description='Bin group definition and relation to storage bins');