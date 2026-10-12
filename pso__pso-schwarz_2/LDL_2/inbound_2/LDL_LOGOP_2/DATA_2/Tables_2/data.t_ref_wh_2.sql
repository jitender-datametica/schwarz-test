/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          data
DB table/view:      t_ref_wh_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-09-24      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_ref_wh_2 for warehouse list
----------------------------------------------------------------------------------------------------
*/
CREATE TABLE DATA.t_ref_wh_2 (
    client_id NUMBER(2,0) NOT NULL COMMENT 'Client ID',
    wh_id NUMBER(10,0) NOT NULL COMMENT 'Warehouse number',
    wh_desc VARCHAR(50) COMMENT 'Warehouse name',
    parent_wh_id NUMBER(10,0) COMMENT 'Parent warehouse number',
    parent_wh_desc VARCHAR(50) COMMENT 'Parent warehouse name',
    dat_opening DATE COMMENT 'Date of opening',
    country_iso_cd VARCHAR(3) COMMENT 'Country_2 ISO code',
    country_desc VARCHAR(35) COMMENT 'Country_2 name',
    country_desc_gb VARCHAR(35) COMMENT 'Country_2 name in English',
    aspect_id NUMBER(1,0) COMMENT 'Aspect ID (1 = BGES, 2 = VGES)',
    dwh_created TIMESTAMP COMMENT 'DWH creation timestamp',
    dwh_src VARCHAR(50) COMMENT 'DWH source',
    PRIMARY KEY (client_id, wh_id)
) COMMENT = 'Warehouse master data'
;
