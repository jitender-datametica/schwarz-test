/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_ref_client_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-09-24      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    FE view v_ref_client_2 for client list
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW fe_mstr_logop.v_ref_client_2 (
   	CLIENT_ID COMMENT 'Client ID',
	COUNTRY_ISO_CD COMMENT 'Country_2 ISO code',
	COUNTRY_DESC COMMENT 'Country_2 name',
	COUNTRY_DESC_GB COMMENT 'Country_2 name in English',
	ASPECT_ID COMMENT 'Aspect ID (1 = BGES, 2 = VGES)',
	DWH_CREATED COMMENT 'DWH creation timestamp',
	DWH_SRC COMMENT 'DWH source'
) COMMENT='Client master data'
 AS 
SELECT
    client_id
    ,country_iso_cd
    ,country_desc
    ,country_desc_gb
    ,aspect_id
    ,dwh_created
    ,dwh_src
FROM "DATA".t_ref_client_2;