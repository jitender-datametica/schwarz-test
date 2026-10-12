/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_ref_wh_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-09-24      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view mv_ref_wh_1 for warehouse list
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_ref_wh_1 (
    client_id COMMENT 'Client ID'
    ,wh_id COMMENT 'Warehouse number'
    ,wh_desc COMMENT 'Warehouse name'
    ,parent_wh_id COMMENT 'Parent warehouse number'
    ,parent_wh_desc COMMENT 'Parent warehouse name'
    ,dat_opening COMMENT 'Date of opening'
    ,country_iso_cd COMMENT 'Country_1 ISO code'
    ,country_desc COMMENT 'Country_1 name'
    ,country_desc_gb COMMENT 'Country_1 name in English'
    ,aspect_id COMMENT 'Aspect ID (1 = BGES, 2 = VGES)'
    ,dwh_created COMMENT 'DWH creation timestamp'
    ,dwh_src COMMENT 'DWH source'
) COMMENT = 'Warehouse master data - materialized view based on t_ref_wh_1'
AS 
SELECT
    client_id
    ,wh_id
    ,wh_desc
    ,parent_wh_id
    ,parent_wh_desc
    ,dat_opening
    ,country_iso_cd
    ,country_desc
    ,country_desc_gb
    ,aspect_id
    ,dwh_created
    ,dwh_src
FROM DATA.t_ref_wh_1
;
