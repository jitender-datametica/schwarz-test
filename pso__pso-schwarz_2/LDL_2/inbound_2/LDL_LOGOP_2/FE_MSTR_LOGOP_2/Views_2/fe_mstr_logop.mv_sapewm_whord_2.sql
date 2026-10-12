/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_whord_2
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
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_whord_2 (
    client_id COMMENT 'Client id - calculated based on the country_2 code'
    ,lidl_ctry COMMENT 'Country_2 code. Original field name bic_zmlila'
    ,src_sys COMMENT 'Source system'
    ,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
    ,wh_id COMMENT 'Warehouse ID'
    ,wh_ord_nr COMMENT 'Warehouse Order Number - Technical name: WHO - Component Type: /SCWM/DE_WHO'
    ,QUEUE COMMENT 'Queue - Technical name: QUEUE - Component Type: /SCWM/DE_QUEUE'
    ,wave COMMENT 'Wave - Technical name: WAVE - Component Type: /SCWM/DE_WAVE'
    ,wh_ord_stat COMMENT 'Warehouse Order Status_2 - Technical name: STATUS_2 - Component Type: /SCWM/DE_WHOSTAT'
    ,wh_ord_act_area COMMENT 'Warehouse Order Activity Area - Technical name: AAREA - Component Type: /SCWM/DE_WHOAA'
    ,crtd_by COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATOR'
    ,crtd_on_dt COMMENT 'Created On - Technical name: CREATED_DATE - Component Type: /SCWM/DE_CREATED_DATE'
    ,crtd_at_tm COMMENT 'Created At - Technical name: CREATED_TIME - Component Type: /SCWM/DE_CREATED_TIME'
    ,processor COMMENT 'Processor - Technical name: PROCESSOR - Component Type: /SCWM/DE_PROCESSOR'
    ,rsrc COMMENT 'Resource (Means of Transportation or User) - Technical name: RSRC - Component Type: /SCWM/DE_RSRC'
    ,start_dt COMMENT 'Start Date - Technical name: STARTED_DATE - Component Type: /SCWM/DE_STARTED_DATE'
    ,start_tm COMMENT 'Start Time - Technical name: STARTED_TIME - Component Type: /SCWM/DE_STARTED_TIME'
    ,last_start_dt COMMENT 'Latest Start Date - Technical name: LS_DATE - Component Type: /SCWM/DE_LS_DATE'
    ,last_start_tm COMMENT 'Latest Start Time - Technical name: LS_TIME - Component Type: /SCWM/DE_LS_TIME'
    ,chg_by COMMENT 'Changed By - Technical name: CHANGED_BY - Component Type: /SCWM/DE_EDITOR'
    ,chg_on_dt COMMENT 'Changed On - Technical name: CHANGED_DATE - Component Type: /SCWM/DE_CHANGED_DATE'
    ,chg_at_tm COMMENT 'Changed At - Technical name: CHANGED_TIME - Component Type: /SCWM/DE_CHANGED_TIME'
    ,conf_by COMMENT 'Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY'
    ,conf_dt COMMENT 'Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE'
    ,conf_tm COMMENT 'Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME'
    ,exec_tm_plan COMMENT 'Planned Execution Time of Warehouse Order - Technical name: PLANDURA - Component Type: /SCWM/DE_WHOPLANDURA'
    ,exec_tm_act COMMENT 'Actual Execution Time of Warehouse Order - Technical name: ACTDURA - Component Type: /SCWM/DE_WHOACTDURA'
    ,wh_ord_tm_unit COMMENT 'Warehouse Order: Time Unit_2 - Technical name: UNIT_T - Component Type: /SCWM/DE_WHOUNITT'
    ,nr_wt COMMENT 'Number of WTs - Technical name: COUNT_TO - Component Type: /SCWM/DE_NO_TO'
    ,wh_ord_contains_pidoc COMMENT 'WO Contains Physical Inventory Document - Technical name: FLGINV - Component Type: /SCWM/DE_FLGINV'
    ,wh_ord_contains_wt COMMENT 'Warehouse Order Contains Warehouse Task - Technical name: FLGTO - Component Type: /SCWM/DE_FLGTO'
    ,tot_proc_tm COMMENT 'Total Processing Time - Technical name: SUM_REACHTIME - Component Type: /SCWM/DE_REACHTT_SUM'
    ,time_unit COMMENT 'Time Unit_2 - Technical name: UNIT_RT - Component Type: /SCWM/LVS_ZEIEI'
    ,plnd_compl_dt COMMENT 'Planned Completion Date - Technical name: PICK_COMP_DATE - Component Type: /SCWM/DE_TOCOMPL_DATE'
    ,plnd_compl_tm COMMENT 'Planned Completion Time - Technical name: PICK_COMP_TIME - Component Type: /SCWM/DE_TOCOMPL_TIME'
    ,dwh_load_id COMMENT 'Load id'
    ,dwh_created COMMENT 'Record created at'
    ,dwh_updated COMMENT 'Record updated at'
) COMMENT = 'SAP EWM warehouse order (materialized view based on table t_logop_sapewm_warehouseorder_2)'
AS
SELECT
    client_id
    ,lidl_country AS lidl_ctry
    ,source_system AS src_sys
    ,wh_nr
    ,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
    ,who_nr AS wh_ord_nr
    ,QUEUE
    ,wave
    ,who_status AS wh_ord_stat
    ,who_activity_area AS wh_ord_act_area
    ,crtd_by
    ,crtd_on_dt
    ,crtd_at_tm
    ,processor
    ,rsrc
    ,start_dt
    ,start_tm
    ,last_start_dt
    ,last_start_tm
    ,changed_by AS chg_by
    ,changed_on_dt AS chg_on_dt
    ,changed_at_tm AS chg_at_tm
    ,conf_by
    ,conf_dt
    ,conf_tm
    ,exec_tm_plan
    ,exec_tm_act
    ,who_time_unit AS wh_ord_tm_unit
    ,nr_wt
    ,who_contains_pi_doc AS wh_ord_contains_pidoc
    ,who_contains_wt AS wh_ord_contains_wt
    ,total_processing_time AS tot_proc_tm
    ,time_unit
    ,planned_compl_dt AS plnd_compl_dt
    ,planned_compl_tm AS plnd_compl_tm
    ,dwh_load_id
    ,dwh_created
    ,dwh_updated
FROM DATA.t_logop_sapewm_warehouseorder_2
;
