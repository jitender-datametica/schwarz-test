/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_goodsin_exception_kpi
Description		|	SAP EWM Goods In - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_goodsin_exception_kpi (client_id
OPTIONS(description='Client ID (PK)'), lidl_ctry OPTIONS(description='Country code'), wh_id
OPTIONS(description='Warehouse ID (PK)'), wh_task_nr OPTIONS(description='Warehouse task number (PK)'), wh_task_item
OPTIONS(description='Warehouse Task Item (PK)'), conf_dt OPTIONS(description='Confirmation date'), conf_tm
OPTIONS(description='Confirmation time'), wh_proc_cat OPTIONS(description='Warehouse process category'), wh_task_stat
OPTIONS(description='Warehouse Task Status'), prod_nr OPTIONS(description='Product number'), prod_desc
OPTIONS(description='Product short description'), doc_nr OPTIONS(description='Document number'), doc_cat
OPTIONS(description='Document category for document-related stocks'), src_hu OPTIONS(description='Source handling unit'),
src_strg_bin OPTIONS(description='Source storage bin'), src_strg_type OPTIONS(description='Source storage type'),
dest_hu OPTIONS(description='Destination handling unit'), dest_strg_bin OPTIONS(description='Destination storage bin'),
dest_strg_type OPTIONS(description='Destination storage type'), queue OPTIONS(description='Queue'), act_area
OPTIONS(description='Activity area'), act_type OPTIONS(description='Activity type'), exc_cd
OPTIONS(description='Exception code'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), receipt_fg OPTIONS(description='Flag for original receipt record'),
dest_strg_bin_clrg OPTIONS(description='Destination storage bin of clearing'), clrg_area
OPTIONS(description='Area of clearing'), rejected_area OPTIONS(description='Area of rejection'), clearing_cnt
OPTIONS(description='Clearing count'), reversal_cnt OPTIONS(description='Reversal count'), underdeliv_cnt
OPTIONS(description='Underdelivery if delivered quantity is smaller than ordered quantity'), clearing_amount
OPTIONS(description='Amount of clearing without underdelivery'))
OPTIONS(DESCRIPTION = `SAP EWM GOODS IN - VIEW WITH FINAL KPIS FOR FE (PK CLIENT_ID, WH_ID, WH_TASK_NR, WH_TASK_ITEM)`)
AS SELECT *
FROM ldl_logop_fe_mstr_logop.v_sapewm_goodsin_exception_add;