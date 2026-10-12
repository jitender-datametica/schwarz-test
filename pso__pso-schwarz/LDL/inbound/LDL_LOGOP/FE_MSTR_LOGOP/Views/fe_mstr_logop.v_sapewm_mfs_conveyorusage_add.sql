/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_mfs_conveyorusage_add
Description		|	SAP EWM MFS - view with additional columns 
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_MFS_CONVEYORUSAGE_ADD(
	CLIENT_ID COMMENT 'Client ID'
	,LIDL_CTRY COMMENT 'Country code'
	,WH_ID COMMENT 'Warehouse ID'
	,WH_TASK_NR COMMENT 'Warehouse Task'
	,WH_TASK_ITEM COMMENT 'Warehouse Task Item'
	,WH_TASK_STAT COMMENT 'Warehouse Task Status'
	,WH_PROC_TYPE COMMENT 'Warehouse Process Type'
	,WH_PROC_CAT COMMENT 'Warehouse Process Category'
	,DOC_NR COMMENT 'Document'
	,DOC_CAT COMMENT 'Document Category for Document-Related Stocks'
	,CONF_DT COMMENT 'Confirmation date'
	,CONF_TM COMMENT 'Confirmation time'
	,CONF_HR COMMENT 'Confirmation hour'
	,QUEUE COMMENT 'Queue'
	,EXC_CD COMMENT 'Exception Code'
	,SRC_STRG_BIN COMMENT 'Source Storage Bin'
	,SRC_HU COMMENT 'Source Handling Unit'
	,SRC_STRG_TYPE COMMENT 'Source Storage Type'
	,SRC_RSRC COMMENT 'Source Resource (Means of Transport or User)'
	,DEST_STRG_BIN COMMENT 'Destination Storage Bin'
	,DEST_HU COMMENT 'Destination Handling Unit'
	,DEST_STRG_TYPE COMMENT 'Destination Storage Type'
	,DEST_RSRC COMMENT 'Destination Resource (Means of Transport or User)'
	,DWH_CREATED COMMENT 'DWH creation timestamp'
	,DWH_UPDATED COMMENT 'DWH update timestamp'
	,CT_ID COMMENT 'Conveyor type ID'
) AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,wh_id
	,tanum AS wh_task_nr
	,tapos AS wh_task_item
	,tostat AS wh_task_stat
	,procty AS wh_proc_type
	,trart AS wh_proc_cat
	,docno AS doc_nr
	,CAST(itemno AS STRING) AS doc_cat
	,confirmed_date AS conf_dt
	,confirmed_time AS conf_tm
	,DATE_TRUNC(HOUR, conf_tm) AS conf_hr
	,QUEUE
	,exccode AS exc_cd
	,vlpla AS src_strg_bin
	,vlenr AS src_hu
	,vltyp AS src_strg_type
	,srsrc AS src_rsrc
	,nlpla AS dest_strg_bin
	,nlenr AS dest_hu
	,nltyp AS dest_strg_type
	,drsrc AS dest_rsrc
	,dwh_created
	,dwh_updated
	,CASE 
		
		WHEN (((client_id, wh_id) IN ((1, 9), (8, 6), (10,7), (18, 4),(13,60)) AND dest_strg_bin LIKE 'HF%' AND src_strg_bin LIKE 'IB-IP2-%' AND wh_proc_type = '8090')
			OR ((client_id, wh_id) = (25, 96) AND dest_strg_bin LIKE 'HF%' AND src_strg_bin LIKE ANY ('IB-IP2-%', 'IB-IPN-%') AND wh_proc_type = '8090')) 
			THEN 1 
		
		WHEN (((client_id, wh_id) IN ((1, 9), (25, 96), (10, 7),(13,60)) AND dest_strg_bin LIKE 'HF%' AND src_strg_bin LIKE 'DI-IP2-%' AND wh_proc_type = '8090')
			OR ((client_id, wh_id) = (8, 6) AND dest_strg_bin LIKE 'HF%' AND src_strg_bin LIKE ANY ('DI-IP2-%', 'DI-IPN-%', 'DI-IPT-%') AND wh_proc_type = '8090'))
			THEN 2
		
		WHEN ((client_id, wh_id) = (1, 9) AND dest_strg_bin LIKE 'HF%' AND src_strg_bin LIKE 'P2-IP2-%' AND wh_proc_type IN ('8090', '8098'))
			
			THEN 3
		
		WHEN ((client_id, wh_id) IN ((10, 7), (18, 4)) AND wh_proc_type = '8090' AND dest_strg_bin LIKE 'HF%' AND src_strg_bin LIKE ('P1-IP2-%'))
			THEN 31
		
		WHEN ((client_id, wh_id) IN ((10, 7), (18, 4)) AND wh_proc_type = '8090' AND dest_strg_bin LIKE 'HF%' AND src_strg_bin LIKE ('P2-IP2-%'))
			THEN 32
		
		
		WHEN (((client_id, wh_id) = (1, 9) AND wh_proc_type IN ('8090', '8098') AND src_strg_bin LIKE 'F1-IP2-%' AND dest_strg_bin LIKE 'F1-PD1-%'))
			THEN 41
		
		WHEN (((client_id, wh_id) = (1, 9) AND wh_proc_type = '8090' AND src_strg_bin LIKE 'B1-IP2-%' AND dest_strg_bin LIKE 'B1-PD1-%'))
			THEN 42
		
		WHEN (((client_id, wh_id) = (1, 9) AND wh_proc_type = '8090' AND src_strg_bin LIKE 'B2-IP2-%' AND dest_strg_bin LIKE 'B2-PD1-%'))
			THEN 43
		
		WHEN ((client_id, wh_id) = (10, 7) AND wh_proc_type = '8090' 
			AND (dest_strg_bin, src_strg_bin) IN (('B1-PD1-1', 'B1-IP2-1'), ('B1-PD1-7', 'B1-IP2-7'), ('B1-PD1-8', 'B1-IP2-8')))
			THEN 44
		
		WHEN ((client_id, wh_id) = (10, 7) AND wh_proc_type = '8090' AND dest_strg_bin = 'B2-PD1-%' AND src_strg_bin = 'B2-IP2-%')
			THEN 45	
		
		WHEN ((client_id, wh_id) = (18, 4) 
			AND wh_proc_type = '8090' 
			AND (dest_strg_bin, src_strg_bin) IN (('B1-PD1-02', 'B1-IP2-02'), ('B1-PD1-04', 'B1-IP2-04'), ('B1-PD1-06', 'B1-IP2-06')))
			THEN 46
		
		WHEN ((client_id, wh_id) IN ((1, 9), (25, 96), (8, 6), (10, 7), (18, 4)) AND wh_proc_type <> '8087' AND dest_strg_bin LIKE 'OB-OF1-%' AND src_strg_type = '8180') 
			THEN 5
		
		WHEN ((client_id, wh_id) IN ((1, 9), (25, 96), (8, 6), (10, 7)) AND wh_proc_type = '8087' AND dest_strg_bin LIKE 'OB-OF1-%')
			THEN 6
		
		WHEN ((client_id, wh_id) = (25, 96) AND  dest_strg_bin LIKE 'OB-PM1-%' AND wh_proc_type = '8084')
			THEN 7
		
		WHEN ((client_id, wh_id) = (8, 6) AND dest_strg_bin = 'DP-IP1-02')
			THEN 8
		
		WHEN ((client_id, wh_id) = (8, 6) AND dest_strg_bin = 'DP-IP1-01')
			THEN 9
		
		WHEN ((client_id, wh_id) IN ((10, 7),(13, 60)) AND dest_strg_bin LIKE 'HF%' AND src_strg_bin LIKE 'N1-IP2-%' AND wh_proc_type = '8090')
			THEN 10
		
		WHEN ((client_id, wh_id) IN ((10, 7), (18, 4)) AND dest_strg_bin LIKE 'F1-OF1-%')
			THEN 11
        
		WHEN ((client_id, wh_id) IN ((13, 60)) AND dest_strg_bin LIKE ANY ('RP-PM1-%','RP-OF1-%', 'OB-OF1%') AND wh_proc_type IN ('8084','8081','8087'))
			THEN 12
        
		WHEN ((client_id, wh_id) IN ((13, 60)) AND dest_strg_bin LIKE ('N1-OF1%') AND wh_proc_type NOT IN ('8097','8088'))
			THEN 13
        
		WHEN ((client_id, wh_id) IN ((13, 60)) AND dest_strg_bin LIKE ('OB-OF1-%') AND wh_proc_type ='8092' AND src_strg_type = '8180')
			THEN 14
        
		WHEN ((client_id, wh_id) IN ((13, 60)) AND dest_strg_bin LIKE ('OB-HPD-%') AND wh_proc_type IN ('8082','8083'))
			THEN 15 
         
		WHEN ((client_id, wh_id) IN ((13, 60)) AND dest_strg_bin LIKE ('OB-HPB-%') AND wh_proc_type IN ('8082','8083') AND dest_strg_type ='8141')
			THEN 151    
		ELSE NULL 
	END AS ct_id
FROM DATA.T_SAPEWM_WAREHOUSETASK 
WHERE wh_task_stat = 'C'
	AND (client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (18, 4), (13,60), (25, 96))
	AND conf_dt BETWEEN Current_date - 360 AND CURRENT_date 
	AND ct_id IS NOT NULL
;