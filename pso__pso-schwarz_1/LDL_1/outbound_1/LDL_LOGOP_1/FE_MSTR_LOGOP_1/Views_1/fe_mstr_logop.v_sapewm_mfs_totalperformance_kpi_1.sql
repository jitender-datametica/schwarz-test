/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_mfs_totalperformance_kpi_1
Description		|	SAP EWM MFS - view with final KPIs for FE
====================================================================================================
*/




CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_mfs_totalperformance_kpi_1 (client_id
OPTIONS(description='Client ID'), lidl_ctry OPTIONS(description='Country_1 code'), wh_id
OPTIONS(description='Warehouse ID'), wh_task_nr OPTIONS(description='Warehouse Task'), wh_task_item
OPTIONS(description='Warehouse Task Item_1'), wh_task_stat OPTIONS(description='Warehouse Task Status_1'), wh_proc_type
OPTIONS(description='Warehouse Process Type'), wh_proc_cat OPTIONS(description='Warehouse Process Category'), doc_nr
OPTIONS(description='Document'), doc_cat OPTIONS(description='Document Category for Document-Related Stocks'),
hu_task_type OPTIONS(description='Handling Unit_1 Type'), unit_switch
OPTIONS(description='Switches between Pallets and EPA amounts'), conf_dt OPTIONS(description='Confirmation date'),
conf_tm OPTIONS(description='Confirmation time'), conf_hr OPTIONS(description='Confirmation hour'), queue
OPTIONS(description='Queue'), src_strg_bin OPTIONS(description='Source Storage Bin'), src_hu
OPTIONS(description='Source Handling Unit_1'), src_strg_type OPTIONS(description='Source Storage Type'), src_rsrc
OPTIONS(description='Source Resource (Means of Transport or User)'), dest_strg_bin
OPTIONS(description='Destination Storage Bin'), dest_hu OPTIONS(description='Destination Handling Unit_1'), dest_strg_type
OPTIONS(description='Destination Storage Type'), dest_rsrc
OPTIONS(description='Destination Resource (Means of Transport or User)'), dwh_created
OPTIONS(description='DWH creation timestamp'), dwh_updated OPTIONS(description='DWH update timestamp'), bin_grp
OPTIONS(description='Storage bin group'), wh_task_type OPTIONS(description='Warehouse task type'), srm_type
OPTIONS(description='Type of storage and retrieval machine (SRM / Regalbediengeraet)'), min_conf_tm
OPTIONS(description='Earliest confirmation time per hour'), max_conf_tm
OPTIONS(description='Latest confirmation time per hour'), cnt_task_ph
OPTIONS(description='Amount of tasks per hour which is shown once for the first row of the hour'), cnt_task_ph_pre
OPTIONS(description='Amount of tasks per hour from the preceding hour group (0 for the first hour per day because there are no previous tasks)'),
cnt_task_ph_suc
OPTIONS(description='Amount of tasks per hour from the succeding hour group (0 for the last hour per day because there are no following tasks)'),
prod_tm_sec OPTIONS(description='Productive time in seconds calculated based on number of tasks per hour'))
OPTIONS(DESCRIPTION = `SAP EWM MFS - VIEW WITH FINAL KPIS FOR FE (PK CLIENT_ID, WH_ID, WH_TASK_NR, WH_TASK_ITEM)`) AS
SELECT *
FROM ldl_logop_fe_mstr_logop.v_sapewm_mfs_totalperformance_add_1;

