/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_inbdlvhdr
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-05      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM inbound delivery header
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_logop_fe_mstr_logop.mv_sapewm_inbdlvhdr AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_nr,
 ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
 doc_nr,
 ship_from_nr,
 vehicle_nr,
 transport_unit,
 adv_ship_notif,
 lia_nr,
 wh_door_nr,
 item_cnt,
 product_cnt AS prod_cnt,
 planned_dlv_dt AS plnd_dlv_dt,
 planned_dlv_tm AS plnd_dlv_tm,
 crtd_on_dt,
 crtd_at_tm,
 purchase_order_nr AS pur_ord_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_logop_data.t_logop_sapewm_inbdlvhdr;