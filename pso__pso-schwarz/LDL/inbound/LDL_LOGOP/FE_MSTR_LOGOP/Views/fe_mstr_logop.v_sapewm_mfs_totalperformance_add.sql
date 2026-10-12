/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_mfs_totalperformance_add
Description		|	SAP EWM MFS - view with additional columns 
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_MFS_TOTALPERFORMANCE_ADD(
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
	,HU_TASK_TYPE COMMENT 'Handling Unit Type'
	,UNIT_SWITCH COMMENT 'Switches between Pallets and EPA amounts' 
	,CONF_DT COMMENT 'Confirmation date'
	,CONF_TM COMMENT 'Confirmation time'
	,CONF_HR COMMENT 'Confirmation hour'
	,QUEUE COMMENT 'Queue'
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
	,BIN_GRP COMMENT 'Storage bin group'
	,WH_TASK_TYPE COMMENT 'Warehouse task type'
	,SRM_TYPE COMMENT 'Type of storage and retrieval machine (SRM / Regalbediengeraet)'
	,MIN_CONF_TM COMMENT 'Earliest confirmation time per hour'
	,MAX_CONF_TM COMMENT 'Latest confirmation time per hour'
	,CNT_TASK_PH COMMENT 'Amount of tasks per hour which is shown once for the first row of the hour'
	,CNT_TASK_PH_PRE COMMENT 'Amount of tasks per hour from the preceding hour group (0 for the first hour per day because there are no previous tasks)'
	,CNT_TASK_PH_SUC COMMENT 'Amount of tasks per hour from the succeding hour group (0 for the last hour per day because there are no following tasks)'
	,PROD_TM_SEC COMMENT 'Productive time in seconds calculated based on number of tasks per hour'
) AS
WITH
nfpallets AS (
	SELECT client_id
		,wh_id
		,tanum AS wh_task_nr
		,tapos AS wh_task_item
		,procty AS wh_proc_type
		,nlpla AS dest_strg_bin
		,nlenr AS dest_hu
	FROM DATA.T_SAPEWM_WAREHOUSETASK 
	WHERE wh_proc_type = '8090'
		AND dest_strg_bin = 'N1-IP2-1'		 
)
,bingroup AS (
	SELECT strg_bin
		,bin_grp
	FROM DATA.T_REF_BIN_GROUP 
) 
,mfstasks AS (
	SELECT
		t.client_id
		,t.lidl_country AS lidl_ctry
		,t.wh_id
		,t.tanum AS wh_task_nr
		,t.tapos AS wh_task_item
		,t.tostat AS wh_task_stat
		,t.procty AS wh_proc_type
		,t.trart AS wh_proc_cat
		,t.docno AS doc_nr
		,CAST(t.itemno AS STRING) AS doc_cat
		,t.letyp AS hu_task_type
		,t.confirmed_date AS conf_dt
		,t.confirmed_time AS conf_tm
		,DATE_TRUNC(HOUR, conf_tm) AS conf_hr
		,t.QUEUE
		,t.vlpla AS src_strg_bin
		,t.vlenr AS src_hu
		,t.vltyp AS src_strg_type
		,t.srsrc AS src_rsrc
		,t.nlpla AS dest_strg_bin
		,t.nlenr AS dest_hu
		,t.nltyp AS dest_strg_type
		,t.drsrc AS dest_rsrc
		,t.dwh_created
		,t.dwh_updated
		,b.bin_grp
		,CASE 
			
			WHEN wh_proc_type = '6666'
				AND t.CLIENT_ID <> 23
				AND t.vltyp = '8141' 
				THEN 7.1				
			
			WHEN wh_proc_type = '8086'
				AND t.CLIENT_ID <> 23
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|6].*')
				AND t.nltyp = '8142'
				THEN 3				
			
			WHEN wh_proc_type = '8287'
				AND t.CLIENT_ID = 23
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|6].*')
				AND t.nlpla LIKE ANY ('TF-DS%')
				THEN 3.2				
			
			WHEN wh_proc_type = '8284'
				AND t.CLIENT_ID = 23
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|6].*')
				AND t.nlpla LIKE ANY ('TF-DS%')
				THEN 3.3				
			
			WHEN wh_proc_type = '8280'
				AND t.CLIENT_ID = 23
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|6].*')
				AND t.nlpla LIKE ANY ('TF-DS%')
				THEN 3.4				
			
			WHEN wh_proc_type = '8086'
				AND t.CLIENT_ID <> 23
				AND t.nlpla LIKE ANY ('HF-DS%','HF-PD%')
				THEN 12 				
			
			WHEN wh_proc_type = '8086'
				AND t.CLIENT_ID <> 23
				AND t.vlpla LIKE ANY ('HF-DS%','HF-PD%')
				AND REGEXP_LIKE(t.nlpla, 'HF-LP0-.*')
				THEN 12.1 							
			
			WHEN wh_proc_type = '8087'
				AND t.CLIENT_ID <> 23
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|5|6].*')
				AND t.nlpla LIKE ANY ('HF-DS%', 'F1-PD1-%', 'P1-PD1-%','HF-PD%')
				THEN 4.0				
			
			WHEN wh_proc_type = '8084'
				AND t.CLIENT_ID <> 23
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|5|6].*')
				AND t.nlpla LIKE ANY ('HF-DS%', 'F1-PD1-%', 'P1-PD1-%','HF-PD%')
				THEN 3.1				
			
			WHEN wh_proc_type = '8088'
				AND t.CLIENT_ID <> 23
				AND t.vltyp = '8141'
				THEN 7.0				
			
			WHEN wh_proc_type = '8288'
				AND t.CLIENT_ID = 23
				AND t.vltyp = '8241'
				THEN 7.2				
						
			WHEN wh_proc_type = '8090'
				AND t.CLIENT_ID <> 23
				AND REGEXP_LIKE(t.nltyp, '814[1|2]')
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|6].*')
				AND doc_cat = 'PDO'
				THEN 2				
			
			WHEN wh_proc_type = '8090'
				AND t.CLIENT_ID <> 23
				AND REGEXP_LIKE(t.nltyp, '814[1|2]')
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|6].*')
				AND NVL(doc_cat, '') <> 'PDO'
				AND NOT t.nlenr IN (SELECT dest_hu FROM nfpallets)
				THEN 1.0				
			
			WHEN wh_proc_type = '8090'
				AND t.CLIENT_ID <> 23
				AND t.nlpla LIKE ANY ('8141%', '8142%')
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|6].*')
				AND NVL(doc_cat, '') <> 'PDO'
				AND t.nlenr IN (SELECT dest_hu FROM nfpallets)
				THEN 1.1				
			
			WHEN wh_proc_type = '8290'	
				AND t.CLIENT_ID = 23
				AND t.nltyp LIKE ANY ('8241%', '8280%')
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|6].*')
				AND NVL(doc_cat, '') <> 'PDO'
				AND NOT t.nlenr IN (SELECT dest_hu FROM nfpallets)
				THEN 1.2				
			
			WHEN wh_proc_type = '8092'
				AND t.CLIENT_ID <> 23
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|5|6].*')
				AND ((t.nlpla LIKE ANY ('OB-OF%', 'OB-PM%', 'F1-OF%', 'RL-OF1-01') 
				        AND t.vlpla LIKE ANY ('HF-DS%', 'F1-PD1-%', 'P1-PD1-%','HF-PD%')) 
                    OR (t.srsrc LIKE 'SR%') 
                    )
				THEN 5.0				
			
			WHEN wh_proc_type = '8092'
				AND t.CLIENT_ID <> 23
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|5|6].*')
				AND t.nlpla LIKE ANY ('OB-OF%', 'OB-PM%', 'F1-OF%', 'RL-OF1-01')
                AND NOT t.vlpla LIKE ANY ('HF-DS%', 'F1-PD1-%', 'P1-PD1-%','HF-PD%')
				THEN 51				
			
			WHEN wh_proc_type = '8292'
				AND t.CLIENT_ID = 23
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|6].*')
				AND t.nlpla LIKE ANY ('TF-DS%')
				THEN 52
				
			WHEN t.CLIENT_ID = 23 
				AND (wh_proc_type LIKE '82%' AND wh_proc_type NOT IN ('8292','8287'))
				AND t.nlpla LIKE ANY ('TF-DS%')
				THEN 52.5					
			
			WHEN wh_proc_type = '8093'
				AND t.CLIENT_ID <> 23
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|6].*')
				AND t.nltyp = '8141'
				THEN 11.0			
			
			WHEN wh_proc_type = '8093'
				AND t.CLIENT_ID <> 23
				AND t.vltyp = '8141'
				THEN 11.1			
			
			WHEN wh_proc_type = '8293'
				AND t.CLIENT_ID = 23
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|6].*')
				AND t.nltyp = '8241'
				THEN 11.2				
			
			WHEN wh_proc_type = '8094'
				AND t.CLIENT_ID <> 23
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|6].*')
				AND t.nltyp = '8141'
				THEN 14.0				
			
			WHEN wh_proc_type IN ('8294','8292')
				AND t.CLIENT_ID = 23
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|6].*')
				AND t.nltyp = '8241'
				THEN 14.2				
			
			WHEN wh_proc_type = '8095'
				AND t.CLIENT_ID <> 23
				AND t.nlpla LIKE ANY ('OB-OF%', 'OB-PM%', 'F1-OF%')
				AND t.vlpla LIKE ANY ('HF-DS%', 'F1-PD1-%', 'P1-PD1-%','HF-PD%')
				THEN 8.0				
			
			WHEN wh_proc_type = '8097'
				AND t.CLIENT_ID <> 23
				AND NOT REGEXP_LIKE(t.vlenr, '9[2|3|4|5|6].*')
				AND t.nlpla = 'N1-OF1-2'
				AND t.vlpla LIKE ANY ('HF-DS%', 'F1-PD1-%', 'P1-PD1-%','HF-PD%') 
				THEN 6.0				
			
			WHEN wh_proc_type = '8098'
				AND t.CLIENT_ID <> 23
				AND t.nlpla LIKE ANY ('OB-OF%', 'OB-PM%', 'F1-OF%', 'RL-OF1-01')
				THEN 9.0				
			
			WHEN REGEXP_LIKE(wh_proc_type, '8\\d\\d\\d')
				AND REGEXP_LIKE(t.vlenr, '9[2|3|4|6].*')
				AND t.CLIENT_ID <> 23
				AND (t.nlpla LIKE ANY ('%SPS%','%EPS%') OR t.nltyp = '8141')
				THEN 10				
			
			WHEN wh_proc_type = '8266'
				AND t.CLIENT_ID = 23
				AND t.vltyp = '8241' 
				THEN 14.5								
			
			WHEN wh_proc_type = '8299'
				AND t.CLIENT_ID = 23
				AND t.vltyp = '8241'
				THEN 15.0					
			ELSE 99
				END AS wh_task_type		
		,CASE 
			WHEN wh_task_type = 99 THEN ''
			WHEN LEFT(t.QUEUE, 2)= 'SR' AND t.CLIENT_ID <> 23 THEN t.QUEUE
			WHEN LEFT(t.QUEUE, 2)= 'S' AND t.CLIENT_ID = 23 THEN t.QUEUE
			WHEN wh_task_type = 51 AND t.CLIENT_ID <> 23 THEN 'Staging Direct' 
			WHEN wh_task_type IN (11.2, 52, 52.5) AND t.CLIENT_ID = 23 THEN t.QUEUE			
			WHEN wh_task_type IN (4,5,6,7,8,10) AND t.CLIENT_ID <> 23 AND t.vlpla LIKE ANY ('HF-DS%' , 'F1-PD1%', 'P1-PD1%') THEN 'SR' || LPAD(REGEXP_SUBSTR(t.vlpla, '\\d\\d', 8), 2, '0')
			WHEN wh_task_type IN (52, 52.5, 15.0, 7.2, 3.4, 3.3, 3.2) AND t.CLIENT_ID = 23 AND t.vlpla LIKE ANY ('TO-OF%', 'F1-PD1%', 'P1-PD1%') THEN 'S' || LPAD(REGEXP_SUBSTR(t.vlpla, '\\d\\d', 8), 2, '0')
			WHEN wh_task_type IN (4,5,6,7,8,10) AND t.CLIENT_ID <> 23 THEN COALESCE(t.srsrc,'') 
			WHEN wh_task_type IN (52, 52.5, 15.0, 7.2, 3.4, 3.3, 3.2) AND t.CLIENT_ID = 23 AND t.srsrc IS NOT NULL THEN COALESCE(t.srsrc,'')
            WHEN  t.CLIENT_ID = 23 AND t.srsrc IS NULL AND (t.QUEUE LIKE ('TAB%') OR t.QUEUE IS NULL) THEN ('Fördertechnik')
            WHEN  t.CLIENT_ID = 23 AND t.srsrc IS NULL AND t.QUEUE NOT LIKE ('TAB%') THEN t.QUEUE
			WHEN wh_task_type IN (11.1, 12.1) AND t.CLIENT_ID <> 23 THEN 'SR' || LPAD(REGEXP_SUBSTR(t.nlpla, '\\d\\d', 8), 2, '0')
			--WHEN wh_task_type IN (11.2) AND t.CLIENT_ID = 23 THEN 'S' || LPAD(REGEXP_SUBSTR(t.nlpla, '\\d\\d', 8), 2, '0')
			ELSE t.srsrc 
				END AS srm_type 
		,MIN(conf_tm) OVER (PARTITION BY t.client_id, wh_id, conf_dt, conf_hr) AS min_conf_tm 
		,MAX(conf_tm) OVER (PARTITION BY t.client_id, wh_id, conf_dt, conf_hr) AS max_conf_tm 
		,IFF(min_conf_tm = conf_tm, COUNT(*) OVER (PARTITION BY t.client_id, wh_id, conf_dt, conf_hr), NULL) AS cnt_task_ph
	FROM DATA.T_SAPEWM_WAREHOUSETASK  t 
		LEFT JOIN bingroup b
			ON t.vlpla = b.strg_bin
	WHERE t.tostat = 'C'
		AND wh_task_type <> 99
)
SELECT 
	client_id
	,lidl_ctry
	,wh_id
	,wh_task_nr
	,wh_task_item
	,wh_task_stat
	,wh_proc_type
	,wh_proc_cat
	,doc_nr
	,doc_cat
	,hu_task_type
	,CAST(1 AS INTEGER) AS unit_switch
	,conf_dt
	,conf_tm
	,conf_hr
	,QUEUE
	,src_strg_bin
	,src_hu
	,src_strg_type
	,src_rsrc
	,dest_strg_bin
	,dest_hu
	,dest_strg_type
	,dest_rsrc
	,dwh_created
	,dwh_updated
	,bin_grp
	,wh_task_type
	,srm_type
	,min_conf_tm
	,max_conf_tm
	,cnt_task_ph
	,IFF(cnt_task_ph IS NOT NULL, LAG(cnt_task_ph, 1,0) IGNORE NULLS OVER (PARTITION BY client_id,wh_id,conf_dt ORDER BY CONF_HR, conf_tm, wh_task_nr), NULL) AS cnt_task_ph_pre
	,IFF(cnt_task_ph IS NOT NULL, LEAD(cnt_task_ph,1,0) IGNORE NULLS OVER (PARTITION BY client_id,wh_id,conf_dt ORDER BY CONF_HR, conf_tm, wh_task_nr), NULL) AS cnt_task_ph_suc
	,CASE 
		WHEN cnt_task_ph < 5 THEN NULL
		WHEN cnt_task_ph_pre + cnt_task_ph_suc < 5 THEN TIMESTAMPDIFF(SECOND, min_conf_tm, max_conf_tm)
		WHEN cnt_task_ph_pre < 5 AND cnt_task_ph_suc > 5 THEN TIMESTAMPDIFF(SECOND, min_conf_tm, TIMEADD(SECOND, 3600, conf_hr))
		WHEN cnt_task_ph_pre > 5 AND cnt_task_ph_suc < 5 THEN TIMESTAMPDIFF(SECOND, conf_hr, max_conf_tm)
		WHEN cnt_task_ph_pre > 5 AND cnt_task_ph_suc > 5 THEN 3600
	END AS prod_tm_sec 
FROM mfstasks

UNION

SELECT 
	client_id
	,lidl_ctry
	,wh_id
	,wh_task_nr
	,wh_task_item
	,wh_task_stat
	,wh_proc_type
	,wh_proc_cat
	,doc_nr
	,doc_cat
	,hu_task_type
	,CAST(2 AS INTEGER) AS unit_switch
	,conf_dt
	,conf_tm
	,conf_hr
	,QUEUE
	,src_strg_bin
	,src_hu
	,src_strg_type
	,src_rsrc
	,dest_strg_bin
	,dest_hu
	,dest_strg_type
	,dest_rsrc
	,dwh_created
	,dwh_updated
	,bin_grp
	,wh_task_type
	,srm_type
	,min_conf_tm
	,max_conf_tm
	,cnt_task_ph
	,IFF(cnt_task_ph IS NOT NULL, LAG(cnt_task_ph, 1,0) IGNORE NULLS OVER (PARTITION BY client_id,wh_id,conf_dt ORDER BY CONF_HR, conf_tm, wh_task_nr), NULL) AS cnt_task_ph_pre
	,IFF(cnt_task_ph IS NOT NULL, LEAD(cnt_task_ph,1,0) IGNORE NULLS OVER (PARTITION BY client_id,wh_id,conf_dt ORDER BY CONF_HR, conf_tm, wh_task_nr), NULL) AS cnt_task_ph_suc
	,CASE 
		WHEN cnt_task_ph < 5 THEN NULL
		WHEN cnt_task_ph_pre + cnt_task_ph_suc < 5 THEN TIMESTAMPDIFF(SECOND, min_conf_tm, max_conf_tm)
		WHEN cnt_task_ph_pre < 5 AND cnt_task_ph_suc > 5 THEN TIMESTAMPDIFF(SECOND, min_conf_tm, TIMEADD(SECOND, 3600, conf_hr))
		WHEN cnt_task_ph_pre > 5 AND cnt_task_ph_suc < 5 THEN TIMESTAMPDIFF(SECOND, conf_hr, max_conf_tm)
		WHEN cnt_task_ph_pre > 5 AND cnt_task_ph_suc > 5 THEN 3600
	END AS prod_tm_sec 
FROM mfstasks
;