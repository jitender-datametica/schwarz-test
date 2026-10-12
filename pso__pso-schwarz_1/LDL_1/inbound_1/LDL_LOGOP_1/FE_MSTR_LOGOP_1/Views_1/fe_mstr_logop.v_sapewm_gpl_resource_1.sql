/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_gpl_resource_1
Description		|	SAP EWM Gruppenleiter Resource
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_GPL_RESOURCE_1(
	CLIENT_ID COMMENT 'Client id (PK)',
	WH_ID COMMENT 'Warehouse ID (PK)',
	RSRC COMMENT 'Resource (Means of Transportation or User)',
	RSRC_TYPE COMMENT 'Resource Type',
	USER COMMENT 'User Name',
	QUEUE COMMENT 'Queue',
	TYPE_FG COMMENT 'Flag for PTWY and Repl.',
	CONF_DT COMMENT 'Logon Date on RF',
	CONF_TM COMMENT 'Logon Time on RF',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	DWH_VALID_FROM COMMENT 'Valid from date',
	DWH_VALID_TO COMMENT 'Valid to date',
	DELETED_FG COMMENT 'Flag if record is deleted'
) COMMENT='SAP EWM Resource view (based on v_sapewm_resource)'
 AS
SELECT 
    CLIENT_ID
   ,WH_ID
   ,RSRC
   ,RSRC_TYPE
   ,UNAME AS USER
   ,ACT_QUEUE AS QUEUE
   ,CASE
   		WHEN ACT_QUEUE LIKE '%REPL%' THEN 'REPL'
   		WHEN ACT_QUEUE LIKE '%INB%' THEN 'PTWY'
   	END AS TYPE_FG
   ,LOGON_DATE AS CONF_DT
   ,LOGON_TIME AS CONF_TM
   ,DWH_CREATED
   ,DWH_UPDATED
   ,DWH_VALID_FROM
   ,DWH_VALID_TO
   ,DELETED_FG
FROM "DATA".T_SAPEWM_RESOURCE_1
WHERE LOGON_DATE = CAST(GETDATE() AS DATE)
	AND (ACT_QUEUE LIKE '%REPL%' OR ACT_QUEUE LIKE '%INB%');