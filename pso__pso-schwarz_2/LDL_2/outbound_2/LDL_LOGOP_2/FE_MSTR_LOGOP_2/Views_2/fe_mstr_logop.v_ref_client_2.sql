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


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_ref_client_2 (client_id OPTIONS(description='Client ID'), country_iso_cd
OPTIONS(description='Country_2 ISO code'), country_desc OPTIONS(description='Country_2 name'), country_desc_gb
OPTIONS(description='Country_2 name in English'), aspect_id OPTIONS(description='Aspect ID (1 = BGES, 2 = VGES)'),
dwh_created OPTIONS(description='DWH creation timestamp'), dwh_src OPTIONS(description='DWH source'))
OPTIONS(DESCRIPTION = `CLIENT MASTER DATA`) AS SELECT *
FROM ldl_logop_data.t_ref_client_2;