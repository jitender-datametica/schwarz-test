/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_ref_client
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-09-24      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view mv_ref_client for client list
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_ref_client (
    client_id COMMENT 'Client ID'
    ,country_iso_cd COMMENT 'Country ISO code'
    ,country_desc COMMENT 'Country name'
    ,country_desc_gb COMMENT 'Country name in English'
    ,aspect_id COMMENT 'Aspect ID (1 = BGES, 2 = VGES)'
    ,dwh_created COMMENT 'DWH creation timestamp'
    ,dwh_src COMMENT 'DWH source'
) COMMENT = 'Client master data - materialized view based on t_ref_client'
AS 
SELECT
    client_id
    ,country_iso_cd
    ,country_desc
    ,country_desc_gb
    ,aspect_id
    ,dwh_created
    ,dwh_src
FROM DATA.t_ref_client
;
