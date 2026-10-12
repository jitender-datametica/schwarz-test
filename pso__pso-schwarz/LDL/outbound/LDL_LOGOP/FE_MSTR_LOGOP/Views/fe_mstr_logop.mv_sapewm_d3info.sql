/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_d3info
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM D3 info
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_logop_fe_mstr_logop.mv_sapewm_d3info AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_nr,
 ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
 freight_unit_id,
 pshu_id,
 hu_id,
 tu_nr,
 activity_area AS act_area,
 sub_activity_area AS sub_act_area,
 bus_partner_nr,
 wave,
 guid_pshu_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_logop_data.t_logop_sapewm_d3info;