/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_whtask_2
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
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_whtask_2 (
    client_id COMMENT 'Client id - calculated based on the country_2 code'
    ,lidl_ctry COMMENT 'Country_2 code. Original field name bic_zmlila'
    ,src_sys COMMENT 'Source system'
    ,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
    ,wh_id COMMENT 'Warehouse ID'
    ,wh_task_nr COMMENT 'Warehouse Task - Technical name: TANUM - Component Type: /SCWM/TANUM'
    ,wh_task_item COMMENT 'Warehouse Task Item_2 - Technical name: TAPOS - Component Type: /SCWM/TAPOS'
    ,hu_fg COMMENT 'Handling Unit_2 Warehouse Task - Technical name: FLGHUTO - Component Type: /SCWM/FLGHUTO'
    ,wh_proc_type COMMENT 'Warehouse Process Type - Technical name: PROCTY - Component Type: /SCWM/DE_PROCTY'
    ,wh_proc_cat COMMENT 'Warehouse Process Category - Technical name: TRART - Component Type: /SCWM/LVS_TRART'
    ,act_type COMMENT 'Activity - Technical name: ACT_TYPE - Component Type: /SCWM/DE_ACTTY'
    ,prod_nr COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'
    ,prod_desc COMMENT 'Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX'
    ,crtd_by COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATOR'
    ,crtd_on_dt COMMENT 'Created On - Technical name: CREATED_DATE - Component Type: /SCWM/DE_CREATED_DATE'
    ,crtd_at_tm COMMENT 'Created At - Technical name: CREATED_TIME - Component Type: /SCWM/DE_CREATED_TIME'
    ,conf_by COMMENT 'Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY'
    ,conf_dt COMMENT 'Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE'
    ,conf_tm COMMENT 'Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME'
    ,wh_task_stat COMMENT 'Warehouse Task Status_2 - Technical name: TOSTAT - Component Type: /SCWM/DE_TOSTAT'
    ,wh_ord_nr COMMENT 'Warehouse Order Number - Technical name: WHO - Component Type: /SCWM/DE_WHO'
    ,QUEUE COMMENT 'Queue - Technical name: QUEUE - Component Type: /SCWM/DE_QUEUE'
    ,src_tgt_qnty_buom COMMENT 'Source Target Quantity in Base Unit_2 of Measure - Technical name: VSOLM - Component Type: /SCWM/DE_UI_VSOLM'
    ,dest_diff_qnty_buom COMMENT 'Destination Difference Quantity in Base Unit_2 of Measure - Technical name: DMENG - Component Type: /SCWM/DE_UI_NDIFM'
    ,buom COMMENT 'Base Unit_2 of Measure - Technical name: MEINS - Component Type: MEINS'
    ,src_tgt_qnty_auom COMMENT 'Source Target Quantity in Alternate Unit_2 of Measure - Technical name: VSOLA - Component Type: /SCWM/DE_UI_VSOLA'
    ,act_dest_qnty_auom COMMENT 'Actual Destination Quantity in Alternative Unit_2 - Technical name: NISTA - Component Type: /SCWM/DE_UI_NISTA'
    ,dest_diff_qnty_auom COMMENT 'Destination Difference Qty in Alternative Unit_2 - Technical name: DMENA - Component Type: /SCWM/DE_UI_NDIFA'
    ,exc_cd COMMENT 'Exception Code - Technical name: EXCCODE - Component Type: /SCWM/DE_EXCCODE'
    ,src_strg_bin COMMENT 'Source Storage Bin - Technical name: VLPLA - Component Type: /SCWM/LTAP_VLPLA'
    ,src_rsrc COMMENT 'Source Resource (Means of Transport or User) - Technical name: SRSRC - Component Type: /SCWM/DE_SRSRC'
    ,src_hu COMMENT 'Source Handling Unit_2 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'
    ,dest_strg_type COMMENT 'Destination Storage Type - Technical name: NLTYP - Component Type: /SCWM/LTAP_NLTYP'
    ,dest_strg_bin COMMENT 'Destination Storage Bin - Technical name: NLPLA - Component Type: /SCWM/LTAP_NLPLA'
    ,dest_rsrc COMMENT 'Destination Resource (Means of Transport or User) - Technical name: DRSRC - Component Type: /SCWM/DE_DRSRC'
    ,dest_hu COMMENT 'Destination Handling Unit_2 - Technical name: NLENR - Component Type: /SCWM/LTAP_NLENR'
    ,src_strg_type COMMENT 'Source Storage Type - Technical name: VLTYP - Component Type: /SCWM/LTAP_VLTYP'
    ,ext_strg_procs_step COMMENT 'External Storage Process Step - Technical name: PROCS - Component Type: /SCWM/DE_PROCS'
    ,wave COMMENT 'Wave - Technical name: WAVE - Component Type: /SCWM/DE_WAVE'
    ,start_dt COMMENT 'Start Date - Technical name: STARTED_DATE - Component Type: /SCWM/DE_STARTED_DATE'
    ,start_tm COMMENT 'Start Time - Technical name: STARTED_TIME - Component Type: /SCWM/DE_STARTED_TIME'
    ,owner_id COMMENT 'Owner - Technical name: OWNER - Component Type: /SCWM/DE_OWNER'
    ,doc_nr COMMENT 'Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT'
    ,act_area COMMENT 'Activity Area - Technical name: AAREA - Component Type: /SCWM/DE_AAREA'
    ,wh_ord_seq COMMENT 'Internal Sequence of Warehouse Order - Technical name: WHOSEQ - Component Type: /SCWM/DE_WHOSEQ_UI'
    ,hu_type COMMENT 'Handling Unit_2 Type - Technical name: LETYP - Component Type: /SCWM/DE_HUTYP'
    ,shelf_life_exp_dt COMMENT 'Shelf Life Expiration Date - Technical name: VFDAT - Component Type: /SCWM/SLED'
    ,gr_dt COMMENT 'Goods Receipt Date - Technical name: GRDATE - Component Type: /SCWM/DE_GR_DATE'
    ,gr_proc_tm COMMENT 'Goods Receipt Processing Time - Technical name: GRTIME - Component Type: /SCWM/DE_GR_TIME'
    ,load_vol COMMENT 'Loading or Net Volume - Technical name: VOLUM - Component Type: /SCWM/DE_NVOLUME'
    ,vol_unit COMMENT 'Volume Unit_2 - Technical name: UNIT_V - Component Type: /SCWM/DE_VOL_UOM'
    ,load_weight COMMENT 'Loading or Net Weight - Technical name: WEIGHT - Component Type: /SCWM/DE_NWEIGHT'
    ,weight_unit COMMENT 'Weight Unit_2 - Technical name: UNIT_W - Component Type: /SCWM/DE_WGT_UOM'
    ,auom COMMENT 'Alternative Unit_2 of Measure for Stockkeeping Unit_2 - Technical name: ALTME - Component Type: /SCWM/DE_AUNIT'
    ,act_qty_dest_buom COMMENT 'Destination Actual Quantity in Stockkeeping Unit_2 - Technical name: NISTM - Component Type: /SCWM/DE_UI_NISTM'
    ,doc_cat COMMENT 'Document Category for Document-Related Stocks - Technical name: QDOCCAT - Component Type: /SCWM/DE_UI_QDOCCAT'
    ,doc_nr_stock_ref COMMENT 'Document Number for Stock Reference - Technical name: QDOCNO - Component Type: /SCWM/DE_QDOCNO_MON'
    ,dwh_load_id COMMENT 'Load id'
    ,dwh_created COMMENT 'Record created at'
    ,dwh_updated COMMENT 'Record updated at'
) COMMENT = 'SAP EWM warehouse tasks (materialized view based on table t_logop_sapewm_warehousetask_2)'
AS
SELECT
    client_id
    ,lidl_country AS lidl_ctry
    ,source_system AS src_sys
    ,wh_nr
    ,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
    ,wh_task_nr
    ,wh_task_item
    ,hu_flg AS hu_fg
    ,wh_process_type AS wh_proc_type
    ,wh_process_cat AS wh_proc_cat
    ,activity_type AS act_type
    ,product_nr AS prod_nr
    ,prod_desc
    ,crtd_by
    ,crtd_on_dt
    ,crtd_at_tm
    ,confirmed_by AS conf_by
    ,confirmed_dt AS conf_dt
    ,confirmed_tm AS conf_tm
    ,wh_task_stat
    ,who_nr AS wh_ord_nr
    ,QUEUE
    ,src_tgt_qnty_buom
    ,dest_diff_qnty_buom
    ,buom
    ,src_tgt_qnty_auom
    ,act_dest_qnty_auom
    ,dest_diff_qnty_auom
    ,exception_cd AS exc_cd
    ,src_strg_bin
    ,src_rsrc
    ,src_hu
    ,dest_strg_type
    ,dest_strg_bin
    ,dest_rsrc
    ,dest_hu
    ,src_strg_type
    ,ext_strg_procs_step
    ,wave
    ,start_dt
    ,start_tm
    ,owner_id
    ,doc_nr
    ,activity_area AS act_area
    ,who_seq AS wh_ord_seq
    ,hu_type
    ,shelf_life_exp_dt
    ,goods_recpt_dt AS gr_dt
    ,goods_recpt_procs_tm AS gr_proc_tm
    ,load_volume AS load_vol
    ,vol_unit
    ,load_weight
    ,weight_unit
    ,auom
    ,act_qty_dest_buom
    ,doc_cat
    ,doc_nr_stock_ref
    ,dwh_load_id
    ,dwh_created
    ,dwh_updated
FROM DATA.t_logop_sapewm_warehousetask_2
;
