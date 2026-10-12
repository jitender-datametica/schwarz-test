/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_ref_bin_group_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2022-03-02      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for bin group definition and relation to storage bin
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_ref_bin_group_2 (
    bin_id COMMENT 'Bin ID'
    ,strg_bin COMMENT 'Storage bin'
    ,bin_grp COMMENT 'Bin group'
    ,dwh_created COMMENT 'DWH creation timestamp'
    ,dwh_src COMMENT 'DWH source'
) COMMENT = 'Bin group definition and relation to storage bin (based on t_ref_bin_group_2)'
AS 
SELECT
    bin_id
    ,strg_bin
    ,bin_grp
    ,dwh_created
    ,dwh_src
FROM DATA.t_ref_bin_group_2
;