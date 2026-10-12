/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_gpl_open_replenishment
Description		|	SAP EWM Open Replenishment
====================================================================================================
*/


CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_GPL_OPEN_REPLENISHMENT(
	CLIENT_ID COMMENT 'Client id (PK)'
	,WH_ID COMMENT 'Warehouse ID (PK)'
	,WH_TASK_NR COMMENT 'Warehouse Task (PK)'
	,WH_TASK_ITEM COMMENT 'Warehouse Task Item (PK)'
	,QUEUE COMMENT 'Queue'
	,AREA COMMENT 'Replenishment Area in Warehouse'
	,PRIORITY COMMENT 'Priority within Replenshment'
	,WH_PROC_TYPE COMMENT 'Process Type within Warehouse'
	,CONF_DT COMMENT 'Date. Orginally Confirmed_by'
	,DWH_CREATED COMMENT 'Record created at'
	,DWH_UPDATED COMMENT 'Record updated at'
) COMMENT='SAP EWM Resource view (based on v_sapewm_resource)'
 AS
SELECT 
    client_id 
    ,wh_id 
--    ,lgnum AS 
    ,tanum AS wh_task_nr
    ,tapos AS wh_task_item
    ,QUEUE
    ,CASE 
	   WHEN QUEUE IN ('REPL_AMB','REPL_S_AMB','REPL1_AMB','REPL2_AMB','REPL3_AMB') THEN 'Ambient'
	   WHEN QUEUE IN ('REPL_BULK','REPL3_BULK', 'REPL_REPACK','REPL_TOPUP','REPL2_BULK','REPL1_BULK') THEN 'Bulk'
	   WHEN QUEUE IN ('REPL_CHL', 'REPL2_CHL', 'REPL3_CHL') THEN 'Chiller'
	   WHEN QUEUE IN ('REPL_FV') THEN 'Fruit and Veg'
	   WHEN QUEUE IN ('REPL_MPF', 'REPL2_MPF', 'REPL3_MPF') THEN 'MPF'
	   WHEN QUEUE IN ('REPL_FRZ', 'REPL2_FRZ', 'REPL3_FRZ') THEN 'Freezer'
	   WHEN QUEUE IN ('REPL_NF','REPL1_NF','REPL2_NF','REPL3_NF') THEN 'NF'
	   ELSE 'Unknown'
     END AS Area
    ,CASE 
       WHEN zz_repl_sort IN (99) THEN 4
       WHEN zz_repl_sort IN (50) THEN 3
       WHEN zz_repl_sort IN (30,25,15) THEN 2
       WHEN zz_repl_sort IN (5,20) THEN 1
    END AS priority
    ,procty AS wh_proc_type
    ,IFF(confirmed_by IS NULL, CAST(GETDATE() AS DATE), confirmed_by) AS conf_dt
    ,DWH_CREATED
    ,DWH_UPDATED
FROM "DATA".T_SAPEWM_WAREHOUSETASK
WHERE created_date >= DATEADD(DAY, -5, CAST(GETDATE()AS DATE)) -- up to 5 days in past
--AND tanum IN (SELECT tanum FROM "DATA".T_SAPEWM_WAREHOUSETASK GROUP BY tanum HAVING COUNT(tanum)<2)
    AND procty LIKE '%Z%'
    AND QUEUE LIKE '%REPL%'
    AND tostat IS NULL
    ;