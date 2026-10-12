/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_goodsin_lanedoorutil_kpi
Description		|	SAP EWM Goods In - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_goodsin_lanedoorutil_kpi (client_id
OPTIONS(description='Client id (PK)'), lidl_ctry OPTIONS(description='Country code'), wh_id
OPTIONS(description='Warehouse ID (PK)'), wh_task_nr OPTIONS(description='Warehouse Task (PK)'), wh_task_item
OPTIONS(description='Warehouse Task Item (PK)'), conf_dt OPTIONS(description='Confirmation date'), conf_tm
OPTIONS(description='Confirmation time'), wh_proc_cat OPTIONS(description='Warehouse Process Category'), wh_task_stat
OPTIONS(description='Warehouse Task Status'), prod_nr OPTIONS(description='Product number'), prod_desc
OPTIONS(description='Product description'), doc_nr OPTIONS(description='Document number (PK)'), doc_cat
OPTIONS(description='Document Category for Document-Related Stocks'), dest_hu
OPTIONS(description='Destination handling unit'), dest_strg_bin OPTIONS(description='Destination storage bin'),
dest_strg_type OPTIONS(description='Destination storage type'), dwh_created OPTIONS(description='Record created at'),
dwh_updated OPTIONS(description='Record updated at'), rev_conf_dt OPTIONS(description='Confirmation date of reversal'),
rev_conf_tm OPTIONS(description='Confirmation time of reversal'), rev_doc_nr
OPTIONS(description='Document number of reversal'), rev_src_hu OPTIONS(description='Source Handling Unit of reversal'),
wh_door_nr OPTIONS(description='Warehouse door number'), plnd_dlv_dt OPTIONS(description='Planned delivery date'))
OPTIONS(DESCRIPTION = `SAP EWM GOODS IN - VIEW WITH FINAL KPIS FOR FE (PK CLIENT_ID, WH_ID, WH_TASK_NR, WH_TASK_ITEM, DOC_NR)`)
AS SELECT *
FROM ldl_logop_fe_mstr_logop.v_sapewm_goodsin_lanedoorutil_add;