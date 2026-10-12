/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_gpl_open_replenishment_1
Description		|	SAP EWM Open Replenishment
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_gpl_open_replenishment_1 (client_id
OPTIONS(description='Client id (PK)'), wh_id OPTIONS(description='Warehouse ID (PK)'), wh_task_nr
OPTIONS(description='Warehouse Task (PK)'), wh_task_item OPTIONS(description='Warehouse Task Item_1 (PK)'), queue
OPTIONS(description='Queue'), area OPTIONS(description='Replenishment Area in Warehouse'), priority
OPTIONS(description='Priority within Replenshment'), wh_proc_type OPTIONS(description='Process Type within Warehouse'),
conf_dt OPTIONS(description='Date. Orginally Confirmed_by'), dwh_created OPTIONS(description='Record created at'),
dwh_updated OPTIONS(description='Record updated at'))
OPTIONS(DESCRIPTION = `SAP EWM RESOURCE VIEW (BASED ON V_SAPEWM_RESOURCE)`) AS SELECT client_id,
 wh_id,
 tanum AS wh_task_nr,
 tapos AS wh_task_item,
 queue,
  CASE
  WHEN queue IN ('REPL_AMB', 'REPL_S_AMB', 'REPL1_AMB', 'REPL2_AMB', 'REPL3_AMB')
  THEN 'Ambient'
  WHEN queue IN ('REPL_BULK', 'REPL3_BULK', 'REPL_REPACK', 'REPL_TOPUP', 'REPL2_BULK', 'REPL1_BULK')
  THEN 'Bulk'
  WHEN queue IN ('REPL_CHL', 'REPL2_CHL', 'REPL3_CHL')
  THEN 'Chiller'
  WHEN queue IN ('REPL_FV')
  THEN 'Fruit and Veg'
  WHEN queue IN ('REPL_MPF', 'REPL2_MPF', 'REPL3_MPF')
  THEN 'MPF'
  WHEN queue IN ('REPL_FRZ', 'REPL2_FRZ', 'REPL3_FRZ')
  THEN 'Freezer'
  WHEN queue IN ('REPL_NF', 'REPL1_NF', 'REPL2_NF', 'REPL3_NF')
  THEN 'NF'
  ELSE 'Unknown'
  END AS area,
  CASE
  WHEN zz_repl_sort IN (99)
  THEN 4
  WHEN zz_repl_sort IN (50)
  THEN 3
  WHEN zz_repl_sort IN (30, 25, 15)
  THEN 2
  WHEN zz_repl_sort IN (5, 20)
  THEN 1
  ELSE NULL
  END AS priority,
 procty AS wh_proc_type,
 IF(confirmed_by IS NULL, SUBSTR(SAFE_CAST(DATE(CURRENT_TIMESTAMP()) as STRING), 1, 20), confirmed_by) AS conf_dt,
 dwh_created,
 dwh_updated
FROM ldl_logop_data.t_sapewm_warehousetask_1
WHERE created_date >= DATE_ADD(DATE(CURRENT_TIMESTAMP()), INTERVAL - 5 DAY)
 AND procty LIKE '%Z%'
 AND queue LIKE '%REPL%'
 AND tostat IS NULL;