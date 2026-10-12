/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_mfs_conveyorusage_kpi_1
Description		|	SAP EWM MFS - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_mfs_conveyorusage_kpi_1 (client_id
OPTIONS(description='Client ID'), lidl_ctry OPTIONS(description='Country_1 code'), wh_id
OPTIONS(description='Warehouse ID'), wh_task_nr OPTIONS(description='Warehouse Task'), wh_task_item
OPTIONS(description='Warehouse Task Item_1'), wh_task_stat OPTIONS(description='Warehouse Task Status_1'), wh_proc_type
OPTIONS(description='Warehouse Process Type'), wh_proc_cat OPTIONS(description='Warehouse Process Category'), doc_nr
OPTIONS(description='Document'), doc_cat OPTIONS(description='Document Category for Document-Related Stocks'), conf_dt
OPTIONS(description='Confirmation date'), conf_tm OPTIONS(description='Confirmation time'), conf_hr
OPTIONS(description='Confirmation hour'), queue OPTIONS(description='Queue'), exc_cd
OPTIONS(description='Exception Code'), src_strg_bin OPTIONS(description='Source Storage Bin'), src_hu
OPTIONS(description='Source Handling Unit_1'), src_strg_type OPTIONS(description='Source Storage Type'), src_rsrc
OPTIONS(description='Source Resource (Means of Transport or User)'), dest_strg_bin
OPTIONS(description='Destination Storage Bin'), dest_hu OPTIONS(description='Destination Handling Unit_1'), dest_strg_type
OPTIONS(description='Destination Storage Type'), dest_rsrc
OPTIONS(description='Destination Resource (Means of Transport or User)'), dwh_created
OPTIONS(description='DWH creation timestamp'), dwh_updated OPTIONS(description='DWH update timestamp'), ct_id
OPTIONS(description='Conveyor type ID'))
OPTIONS(DESCRIPTION = `SAP EWM MFS - VIEW WITH FINAL KPIS FOR FE (PK CLIENT_ID, WH_ID, WH_TASK_NR, WH_TASK_ITEM, CT_ID)`)
AS SELECT *
FROM ldl_logop_fe_mstr_logop.v_sapewm_mfs_conveyorusage_add_1;