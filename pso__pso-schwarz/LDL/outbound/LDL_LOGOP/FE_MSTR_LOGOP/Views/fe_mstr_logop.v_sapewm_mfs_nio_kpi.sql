/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_mfs_nio_kpi
Description		|	SAP EWM MFS - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_mfs_nio_kpi (client_id OPTIONS(description='Client ID'),
lidl_ctry OPTIONS(description='Country code'), wh_id OPTIONS(description='Warehouse ID'), wh_task_nr
OPTIONS(description='Warehouse Task'), wh_task_item OPTIONS(description='Warehouse Task Item'), wh_task_stat
OPTIONS(description='Warehouse Task Status'), wh_proc_type OPTIONS(description='Warehouse Process Type'), wh_proc_cat
OPTIONS(description='Warehouse Process Category'), doc_nr OPTIONS(description='Document'), doc_cat
OPTIONS(description='Document Category for Document-Related Stocks'), conf_dt OPTIONS(description='Confirmation date'),
conf_tm OPTIONS(description='Confirmation time'), queue OPTIONS(description='Queue'), exc_cd
OPTIONS(description='Exception Code'), src_strg_bin OPTIONS(description='Source Storage Bin'), src_hu
OPTIONS(description='Source Handling Unit'), src_strg_type OPTIONS(description='Source Storage Type'), src_rsrc
OPTIONS(description='Source Resource (Means of Transport or User)'), dest_strg_bin
OPTIONS(description='Destination Storage Bin'), dest_hu OPTIONS(description='Destination Handling Unit'), dest_strg_type
OPTIONS(description='Destination Storage Type'), dest_rsrc
OPTIONS(description='Destination Resource (Means of Transport or User)'), dwh_created
OPTIONS(description='DWH creation timestamp'), dwh_updated OPTIONS(description='DWH update timestamp'), hu_ident
OPTIONS(description='NIO History Handling Unit Identification'), log_seq OPTIONS(description='NIO History Log Sequence'),
crtd_on_dt OPTIONS(description='NIO History Created on'), com_point
OPTIONS(description='NIO History Communication Point for Conveyor Technique'), hu_stat_short
OPTIONS(description='NIO History Individual status of an object in short form'), err_cd
OPTIONS(description='NIO History error code used to identify pallets with relevant errors'), first_log_seq
OPTIONS(description='Indicator to identify the first record of Nio History per task group'), hu_checked
OPTIONS(description='Pallet provided to conveyor'), hu_passed OPTIONS(description='Pallet successfully checked'),
nio_count OPTIONS(description='Pallet with encountered error'), nio_sonstige
OPTIONS(description='Pallet manually moved to NIO Station'), send_out
OPTIONS(description='Pallet moved to clearing station'), nio_send_out
OPTIONS(description='TAB Only: Pallet moved to clearing station'), conveyor_id
OPTIONS(description='ID for the FE lookup of conveyor and area (LU view v_lu_mfs_conveyor)'))
OPTIONS(DESCRIPTION = `SAP EWM MFS - VIEW WITH FINAL KPIS FOR FE (PK CLIENT_ID, WH_ID, WH_TASK_NR, WH_TASK_ITEM, HU_IDENT, LOG_SEQ)`)
AS SELECT *
FROM ldl_logop_fe_mstr_logop.v_sapewm_mfs_nio_add;