/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_ref_wh
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-09-24      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    FE view v_ref_wh for warehouse list
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_ref_wh (client_id OPTIONS(description='Client ID'), wh_id
OPTIONS(description='Warehouse number'), wh_desc OPTIONS(description='Warehouse name'), parent_wh_id
OPTIONS(description='Parent warehouse number'), parent_wh_desc OPTIONS(description='Parent warehouse name'), dat_opening
OPTIONS(description='Date of opening'), country_iso_cd OPTIONS(description='Country ISO code'), country_desc
OPTIONS(description='Country name'), country_desc_gb OPTIONS(description='Country name in English'), aspect_id
OPTIONS(description='Aspect ID (1 = BGES, 2 = VGES)'), dwh_created OPTIONS(description='DWH creation timestamp'),
dwh_src OPTIONS(description='DWH source')) OPTIONS(DESCRIPTION = `WAREHOUSE MASTER DATA`) AS SELECT *
FROM ldl_logop_data.t_ref_wh;