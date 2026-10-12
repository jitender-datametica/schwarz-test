/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_whord_1
Description		|	SAP EWM - base view
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_whord_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), lidl_ctry
OPTIONS(description='Country_1 code. Original field name bic_zmlila'), src_sys
OPTIONS(description='Source system. Source column name: source_system'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number'), wh_nr
OPTIONS(description='Warehouse Number/Warehouse Complex. Source column name: LGNUM'), wh_ord_nr
OPTIONS(description='Warehouse Order Number. Source column name: WHO'), wh_ord_crt_rule
OPTIONS(description='Warehouse Order Creation Rule. Source column name: WCR'), cat_wh_ord_crt_rule
OPTIONS(description='Category of Warehouse Order Creation Rule. Source column name: CAT_TYPE'), doc_hdr_wh_proc_type
OPTIONS(description='Document Header Warehouse Process Type. Source column name: HDR_PROCTY'), queue
OPTIONS(description='Queue'), wave OPTIONS(description='Wave'), who_status
OPTIONS(description='Warehouse Order Status. Source column name: STATUS_1'), act_area
OPTIONS(description='Warehouse Order Activity Area. Source column name: AAREA'), crtd_by
OPTIONS(description='Created By. Source column name: CREATED_BY'), crtd_on_dt
OPTIONS(description='Created On. Source column name: CREATED_DATE'), crtd_at_tm
OPTIONS(description='Created At. Source column name: CREATED_TIME'), processor OPTIONS(description='Processor'), rsrc
OPTIONS(description='Resource (Means of Transportation or User)'), start_dt
OPTIONS(description='Start Date. Source column name: STARTED_DATE'), start_tm
OPTIONS(description='Start Time. Source column name: STARTED_TIME'), last_start_dt
OPTIONS(description='Latest Start Date. Source column name: LS_DATE'), last_start_tm
OPTIONS(description='Latest Start Time. Source column name: LS_TIME'), changed_by OPTIONS(description='Changed By'),
changed_on_dt OPTIONS(description='Changed On. Source column name: CHANGED_DATE'), changed_at_tm
OPTIONS(description='Changed At. Source column name: CHANGED_TIME'), conf_by
OPTIONS(description='Confirmed by. Source column name: CONFIRMED_BY'), conf_dt
OPTIONS(description='Confirmation Date. Source column name: CONFIRMED_DATE'), conf_tm
OPTIONS(description='Confirmation Time. Source column name: CONFIRMED_TIME'), exec_tm_plan
OPTIONS(description='Planned Execution Time of Warehouse Order. Source column name: PLANDURA'), exec_tm_act
OPTIONS(description='Actual Execution Time of Warehouse Order. Source column name: ACTDURA'), who_tm_unit
OPTIONS(description='Warehouse Order: Time Unit. Source column name: UNIT_T'), wh_ord_nr_top
OPTIONS(description='Warehouse Order Number of Higher-Level Warehouse Order. Source column name: TOPWHOID'),
wh_ord_nr_ref OPTIONS(description='Warehouse Order Number of Subsequent Warehouse Order. Source column name: REFWHOID'),
who_contains_pi_doc OPTIONS(description='WO Contains Physical Inventory Document. Source column name: FLGINV'),
who_contains_fg OPTIONS(description='WO Contains Warehouse Order. Source column name: FLGWHO'), who_contains_wt
OPTIONS(description='Warehouse Order Contains Warehouse Task. Source column name: FLGTO'), who_log_nr
OPTIONS(description='Warehouse Order Log Number. Source column name: WHOLOGNO'), nr_wt
OPTIONS(description='Number of WTs. Source column name: COUNT_TO'), wt_tot
OPTIONS(description='Total Weight. Source column name: SUM_WEIGHT'), wt_unit
OPTIONS(description='Weight Unit. Source column name: UNIT_W'), vol_sum
OPTIONS(description='Total Volume. Source column name: SUM_VOLUM'), vol_unit
OPTIONS(description='Volume Unit. Source column name: UNIT_V'), total_processing_time
OPTIONS(description='Total Processing Time. Source column name: SUM_REACHTIME'), tm_unit
OPTIONS(description='Time Unit. Source column name: UNIT_RT'), pick_comp_dt
OPTIONS(description='Planned Completion Date'), pick_comp_tm OPTIONS(description='Planned Completion Time'), wave_type
OPTIONS(description='Wave Type'), wh_ord_nr_split
OPTIONS(description='Warehouse Order Number of WO That Was Split. Source column name: SPLITWHOID'), who_split_fg
OPTIONS(description='Warehouse Order Was Split. Source column name: WHO_SPLIT FLGSPLIT'), hazard_substance
OPTIONS(description='Hazardous Substance Relevant for Storage. Source column name: HAZMAT'), start_bin
OPTIONS(description='Starting Point for Processing Resource'), who_dummy
OPTIONS(description='Dummy_1 function in length 1. Source column name:WHO_DUMMY'), store_nr
OPTIONS(description='Store Number. Source column name: ZZ_SHIP_TO'), store_name
OPTIONS(description='Store Name. Source column name: ZZ_SHIP_TO_NAME'), delay_stat_wh_queue
OPTIONS(description='delay status_1 for WO in queue. Source column name: ZZ_STAG_DELAY'), pshu_ind
OPTIONS(description='PSHU Indicator. Source column name: ZZ_PSHU_IND'), pshu_whohu
OPTIONS(description='PSHU Guid from WHOHU. Source column name: ZZ_PSHU_WHOHU'), pshu_hdr
OPTIONS(description='PSHU Guid from Header. Source column name: ZZ_PSHU_HDR'), dwh_load_id
OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'))
OPTIONS(DESCRIPTION = `SAP EWM - BASE VIEW FOR WAREHOUSE ORDER FOR BI REPORTING`) AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_id,
 lgnum AS wh_nr,
 who AS wh_ord_nr,
 wcr AS wh_ord_crt_rule,
 cat_type AS cat_wh_ord_crt_rule,
 hdr_procty AS doc_hdr_wh_proc_type,
 queue,
 wave,
 status_1 AS who_status,
 aarea AS act_area,
 created_by AS crtd_by,
 created_date AS crtd_on_dt,
 created_time AS crtd_at_tm,
 processor,
 rsrc,
 started_date AS start_dt,
 started_time AS start_tm,
 ls_date AS last_start_dt,
 ls_time AS last_start_tm,
 changed_by,
 changed_date AS changed_on_dt,
 changed_time AS changed_at_tm,
 confirmed_by AS conf_by,
 confirmed_date AS conf_dt,
 confirmed_time AS conf_tm,
 plandura AS exec_tm_plan,
 actdura AS exec_tm_act,
 unit_t AS who_tm_unit,
 topwhoid AS wh_ord_nr_top,
 refwhoid AS wh_ord_nr_ref,
 flginv AS who_contains_pi_doc_fg,
 flgwho AS who_contains_wo_fg,
 flgto AS who_contains_wt_fg,
 whologno AS who_log_nr,
 count_to AS nr_wt,
 sum_weight AS wt_tot,
 unit_w AS wt_unit,
 sum_volum AS vol_sum,
 unit_v AS vol_unit,
 sum_reachtime AS total_processing_time,
 unit_rt AS tm_unit,
 pick_comp_date AS pick_comp_dt,
 pick_comp_time AS pick_comp_tm,
 wave_type,
 splitwhoid AS wh_ord_nr_split,
 flgsplit AS who_split_fg,
 hazmat AS hazard_substance,
 start_bin,
 who_dummy,
 zz_ship_to AS store_nr,
 zz_ship_to_name AS store_name,
 zz_stag_delay AS delay_stat_wh_queue,
 zz_pshu_ind AS pshu_ind,
 zz_pshu_whohu AS pshu_whohu,
 zz_pshu_hdr AS pshu_hdr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_logop_data.t_sapewm_warehouseorder_1;