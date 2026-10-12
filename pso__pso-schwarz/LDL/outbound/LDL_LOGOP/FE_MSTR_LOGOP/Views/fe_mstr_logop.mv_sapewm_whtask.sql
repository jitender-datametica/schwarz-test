/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_whtask
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-09-30      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM warehouse tasks
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_logop_fe_mstr_logop.mv_sapewm_whtask AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_nr,
 ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
 wh_task_nr,
 wh_task_item,
 hu_flg AS hu_fg,
 wh_process_type AS wh_proc_type,
 wh_process_cat AS wh_proc_cat,
 activity_type AS act_type,
 product_nr AS prod_nr,
 prod_desc,
 crtd_by,
 crtd_on_dt,
 crtd_at_tm,
 confirmed_by AS conf_by,
 confirmed_dt AS conf_dt,
 confirmed_tm AS conf_tm,
 wh_task_stat,
 who_nr AS wh_ord_nr,
 queue,
 src_tgt_qnty_buom,
 dest_diff_qnty_buom,
 buom,
 src_tgt_qnty_auom,
 act_dest_qnty_auom,
 dest_diff_qnty_auom,
 exception_cd AS exc_cd,
 src_strg_bin,
 src_rsrc,
 src_hu,
 dest_strg_type,
 dest_strg_bin,
 dest_rsrc,
 dest_hu,
 src_strg_type,
 ext_strg_procs_step,
 wave,
 start_dt,
 start_tm,
 owner_id,
 doc_nr,
 activity_area AS act_area,
 who_seq AS wh_ord_seq,
 hu_type,
 shelf_life_exp_dt,
 goods_recpt_dt AS gr_dt,
 goods_recpt_procs_tm AS gr_proc_tm,
 load_volume AS load_vol,
 vol_unit,
 load_weight,
 weight_unit,
 auom,
 act_qty_dest_buom,
 doc_cat,
 doc_nr_stock_ref,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_logop_data.t_logop_sapewm_warehousetask;