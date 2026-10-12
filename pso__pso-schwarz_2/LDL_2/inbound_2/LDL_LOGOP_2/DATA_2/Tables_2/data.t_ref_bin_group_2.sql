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
CREATE TABLE DATA.t_ref_bin_group_2 (
	bin_id NUMBER(3,0) COMMENT 'Bin ID',
	strg_bin VARCHAR(10) COMMENT 'Storage bin',
    bin_grp VARCHAR(50) COMMENT 'Bin group',
	dwh_created TIMESTAMP_NTZ(9) COMMENT 'DWH creation timestamp',
	dwh_src VARCHAR(50) COMMENT 'DWH source',
    PRIMARY KEY (bin_id)
) COMMENT = 'Bin group definition and relation to storage bins'
;