/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_whord
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-09-30      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM warehouse order
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_logop_fe_mstr_logop.mv_sapewm_whord AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_nr,
 ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
 who_nr AS wh_ord_nr,
 queue,
 wave,
 who_status AS wh_ord_stat,
 who_activity_area AS wh_ord_act_area,
 crtd_by,
 crtd_on_dt,
 crtd_at_tm,
 processor,
 rsrc,
 start_dt,
 start_tm,
 last_start_dt,
 last_start_tm,
 changed_by AS chg_by,
 changed_on_dt AS chg_on_dt,
 changed_at_tm AS chg_at_tm,
 conf_by,
 conf_dt,
 conf_tm,
 exec_tm_plan,
 exec_tm_act,
 who_time_unit AS wh_ord_tm_unit,
 nr_wt,
 who_contains_pi_doc AS wh_ord_contains_pidoc,
 who_contains_wt AS wh_ord_contains_wt,
 total_processing_time AS tot_proc_tm,
 time_unit,
 planned_compl_dt AS plnd_compl_dt,
 planned_compl_tm AS plnd_compl_tm,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_logop_data.t_logop_sapewm_warehouseorder;