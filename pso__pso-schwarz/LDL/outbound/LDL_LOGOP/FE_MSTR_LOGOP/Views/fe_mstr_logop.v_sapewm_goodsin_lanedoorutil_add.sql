/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_goodsin_lanedoorutil_add
Description		|	SAP EWM Goods In - view with additional columns 
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_goodsin_lanedoorutil_add (client_id
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
OPTIONS(DESCRIPTION = `SAP EWM GOODS IN - VIEW WITH ADDITIONAL COLUMNS (PK CLIENT_ID, WH_ID, WH_TASK_NR, WH_TASK_ITEM, DOC_NR)`)
AS WITH WHTREC AS (SELECT client_id,
   lidl_country AS lidl_ctry,
   ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
   wh_task_nr,
   wh_task_item,
   confirmed_dt AS conf_dt,
   confirmed_tm AS conf_tm,
   wh_process_cat AS wh_proc_cat,
   wh_task_stat,
   product_nr AS prod_nr,
   prod_desc,
   doc_nr,
   doc_cat,
   src_hu,
   src_strg_bin,
   src_strg_type,
   dest_hu,
   dest_strg_bin,
   dest_strg_type,
   dwh_created,
   dwh_updated
  FROM ldl_logop_data.t_logop_sapewm_warehousetask
  WHERE CAST(wh_process_cat AS FLOAT64) = 5
   AND wh_task_stat = 'C'
   AND doc_nr IS NOT NULL
   AND dest_hu IS NOT NULL), WHTREV AS (SELECT client_id,
   lidl_country AS lidl_ctry,
   ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
   wh_task_nr,
   wh_task_item,
   confirmed_dt AS conf_dt,
   confirmed_tm AS conf_tm,
   wh_process_cat AS wh_proc_cat,
   wh_task_stat,
   product_nr AS prod_nr,
   prod_desc,
   doc_nr,
   doc_cat,
   src_hu,
   src_strg_bin,
   src_strg_type,
   dest_hu,
   dest_strg_bin,
   dest_strg_type,
   dwh_created,
   dwh_updated
  FROM ldl_logop_data.t_logop_sapewm_warehousetask
  WHERE CAST(wh_process_cat AS FLOAT64) = 6
   AND doc_cat = 'PDI'
   AND wh_task_stat = 'C'
   AND doc_nr IS NOT NULL
   AND src_hu IS NOT NULL), INBDLVHDR AS (SELECT client_id,
   lidl_country AS lidl_ctry,
   source_system AS src_sys,
   wh_nr,
   ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
   doc_nr,
   ship_from_nr,
   vehicle_nr,
   transport_unit,
   adv_ship_notif,
   lia_nr,
   wh_door_nr,
   item_cnt,
   product_cnt AS prod_cnt,
   planned_dlv_dt AS plnd_dlv_dt,
   planned_dlv_tm AS plnd_dlv_tm,
   crtd_on_dt,
   crtd_at_tm,
   purchase_order_nr AS pur_ord_nr,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM ldl_logop_data.t_logop_sapewm_inbdlvhdr) (SELECT rc.client_id,
   rc.lidl_ctry,
   rc.wh_id,
   rc.wh_task_nr,
   rc.wh_task_item,
   rc.conf_dt,
   rc.conf_tm,
   rc.wh_proc_cat,
   rc.wh_task_stat,
   rc.prod_nr,
   rc.prod_desc,
   rc.doc_nr,
   rc.doc_cat,
   rc.dest_hu,
   rc.dest_strg_bin,
   rc.dest_strg_type,
   rc.dwh_created,
   rc.dwh_updated,
   rv.conf_dt AS rev_conf_dt,
   rv.conf_tm AS rev_conf_tm,
   rv.doc_nr AS rev_doc_nr,
   rv.src_hu AS rev_src_hu,
   IFNULL(i.wh_door_nr, 'Unassigned'),
   i.plnd_dlv_dt
  FROM WHTREC AS rc
   LEFT JOIN WHTREV AS rv ON rc.client_id = rv.client_id AND rc.wh_id = rv.wh_id AND rc.dest_hu = rv.src_hu AND rc.conf_dt
       <= rv.conf_dt AND rc.doc_nr = rv.doc_nr
   LEFT JOIN INBDLVHDR AS i ON rc.client_id = i.client_id AND rc.wh_id = i.wh_id AND rc.doc_nr = i.doc_nr
  WHERE rv.conf_dt IS NULL
   AND rc.dest_strg_type <> '9996');