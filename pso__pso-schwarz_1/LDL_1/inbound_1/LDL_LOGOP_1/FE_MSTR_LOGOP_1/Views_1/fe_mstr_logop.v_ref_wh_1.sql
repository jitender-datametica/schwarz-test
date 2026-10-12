/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_ref_wh_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-09-24      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    FE view v_ref_wh_1 for warehouse list
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW fe_mstr_logop.v_ref_wh_1 (
   	CLIENT_ID COMMENT 'Client ID',
	WH_ID COMMENT 'Warehouse number',
	WH_DESC COMMENT 'Warehouse name',
	PARENT_WH_ID COMMENT 'Parent warehouse number',
	PARENT_WH_DESC COMMENT 'Parent warehouse name',
	DAT_OPENING COMMENT 'Date of opening',
	COUNTRY_ISO_CD COMMENT 'Country_1 ISO code',
	COUNTRY_DESC COMMENT 'Country_1 name',
	COUNTRY_DESC_GB COMMENT 'Country_1 name in English',
	ASPECT_ID COMMENT 'Aspect ID (1 = BGES, 2 = VGES)',
	DWH_CREATED COMMENT 'DWH creation timestamp',
	DWH_SRC COMMENT 'DWH source'
) COMMENT='Warehouse master data'
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
FROM "DATA".t_ref_wh_1;