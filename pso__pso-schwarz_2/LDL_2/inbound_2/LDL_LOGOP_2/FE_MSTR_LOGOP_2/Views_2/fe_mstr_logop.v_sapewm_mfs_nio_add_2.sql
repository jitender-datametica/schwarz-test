CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_MFS_NIO_ADD_2(
	CLIENT_ID COMMENT 'Client ID'
	,LIDL_CTRY COMMENT 'Country_2 code'
	,WH_ID COMMENT 'Warehouse ID'
	,WH_TASK_NR COMMENT 'Warehouse Task'
	,WH_TASK_ITEM COMMENT 'Warehouse Task Item_2'
	,WH_TASK_STAT COMMENT 'Warehouse Task Status_2'
	,WH_PROC_TYPE COMMENT 'Warehouse Process Type'
	,WH_PROC_CAT COMMENT 'Warehouse Process Category'
	,DOC_NR COMMENT 'Document'
	,DOC_CAT COMMENT 'Document Category for Document-Related Stocks'
	,CONF_DT COMMENT 'Confirmation date'
	,CONF_TM COMMENT 'Confirmation time'
	,QUEUE COMMENT 'Queue'
	,EXC_CD COMMENT 'Exception Code'
	,SRC_STRG_BIN COMMENT 'Source Storage Bin'
	,SRC_HU COMMENT 'Source Handling Unit_2'
	,SRC_STRG_TYPE COMMENT 'Source Storage Type'
	,SRC_RSRC COMMENT 'Source Resource (Means of Transport or User)'
	,DEST_STRG_BIN COMMENT 'Destination Storage Bin'
	,DEST_HU COMMENT 'Destination Handling Unit_2'
	,DEST_STRG_TYPE COMMENT 'Destination Storage Type'
	,DEST_RSRC COMMENT 'Destination Resource (Means of Transport or User)'
	,DWH_CREATED COMMENT 'DWH creation timestamp'
	,DWH_UPDATED COMMENT 'DWH update timestamp'
	,HU_IDENT COMMENT 'NIO History Handling Unit_2 Identification'
	,LOG_SEQ COMMENT 'NIO History Log Sequence'
	,CRTD_ON_DT COMMENT 'NIO History Created on'
	,COM_POINT COMMENT 'NIO History Communication_2 Point for Conveyor Technique'
	,HU_STAT_SHORT COMMENT 'NIO History Individual status_2 of an object in short form'
	,ERR_CD COMMENT 'NIO History error code used to identify pallets with relevant errors'
	,FIRST_LOG_SEQ COMMENT 'Indicator to identify the first record of Nio History per task group'
	,HU_CHECKED COMMENT 'Pallet provided to conveyor'
	,HU_PASSED COMMENT 'Pallet successfully checked'
	,NIO_COUNT COMMENT 'Pallet with encountered error'
	,NIO_SONSTIGE COMMENT 'Pallet manually moved to NIO Station'
	,SEND_OUT COMMENT 'Pallet moved to clearing station'
	,NIO_SEND_OUT COMMENT 'TAB Only: Pallet moved to clearing station'
	,CONVEYOR_ID COMMENT 'ID for the FE lookup of conveyor and area (LU view v_lu_mfs_conveyor_2)'
) AS
WITH nio AS (
	SELECT
		wht.client_id
		,wht.lidl_country AS lidl_ctry
		,wht.wh_id
		,wht.tanum AS wh_task_nr
		,wht.tapos AS wh_task_item
		,wht.tostat AS wh_task_stat
		,wht.procty AS wh_proc_type
		,wht.trart AS wh_proc_cat
		,wht.docno AS doc_nr
		,wht.itemno AS doc_cat
		,wht.confirmed_date AS conf_dt
		,wht.confirmed_time AS conf_tm
		,wht.QUEUE
		,wht.exccode AS exc_cd
		,wht.vlpla AS src_strg_bin
		,wht.vlenr AS src_hu
		,wht.vltyp AS src_strg_type
		,wht.srsrc AS src_rsrc
		,wht.nlpla AS dest_strg_bin
		,wht.nlenr AS dest_hu
		,wht.nltyp AS dest_strg_type
		,wht.drsrc AS dest_rsrc
		,wht.dwh_created
		,wht.dwh_updated
		,DECODE((wht.client_id, wht.wh_id),
			(1, 9),
				CASE 
					WHEN STARTSWITH(src_strg_bin, 'IB-IP2') AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR STARTSWITH(src_strg_bin, 'IB-IP2') AND dest_strg_bin LIKE ANY ('HF%', 'OB-OF%', 'RL-OF1-01%') 
						OR STARTSWITH(dest_strg_bin, 'IB-IP2') AND NVL(exc_cd, '') <> 'MLOC' 
						OR STARTSWITH(dest_strg_bin, 'IB-NO1') AND NOT wh_proc_type IN ('8099','9999') AND NOT (wh_proc_type = '8091' AND NOT STARTSWITH(src_strg_bin, 'HF')) 
						OR STARTSWITH(dest_strg_bin, 'IB-NO1') AND wh_proc_type = '8091' AND NOT STARTSWITH(src_strg_bin, 'IB-SCN-01') AND NOT STARTSWITH(src_strg_bin, 'HF') 
                        OR (src_strg_bin LIKE 'IB-%' AND dest_strg_bin = 'IB-OF1-01') 
						THEN 1
					WHEN STARTSWITH(src_strg_bin, 'DI-IP2') AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR STARTSWITH(src_strg_bin, 'DI-IP2') AND dest_strg_bin LIKE ANY ('HF%', 'OB-OF%', 'RL-OF1-01%') 
						OR STARTSWITH(dest_strg_bin, 'DI-IP2') AND NVL(exc_cd, '') <> 'MLOC' 
						OR STARTSWITH(dest_strg_bin, 'DI-NO1') AND NOT wh_proc_type IN ('8099','9999') AND NOT (wh_proc_type = '8091' AND NOT STARTSWITH(src_strg_bin, 'HF')) 
						OR STARTSWITH(dest_strg_bin, 'DI-NO1') AND wh_proc_type = '8091' AND NOT STARTSWITH(src_strg_bin, 'HF') 
                        OR (src_strg_bin LIKE 'DI-%' AND dest_strg_bin = 'RL-OF1-01') 
						THEN 2
					WHEN STARTSWITH(src_strg_bin, 'P2-IP2') AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR STARTSWITH(src_strg_bin, 'P2-IP2') AND dest_strg_bin LIKE ANY ('HF%', 'OB-OF%', 'RL-OF1-01%') 
						OR STARTSWITH(src_strg_bin, 'P2-IP1') AND dest_strg_bin LIKE ANY ('P2-IP2%', 'P2-NO1%') AND NOT (STARTSWITH(dest_hu, '3') AND NVL(exc_cd, '') = 'MLOC') 
						OR STARTSWITH(dest_strg_bin, 'P2-IP1') 
						OR STARTSWITH(dest_strg_bin, 'P2-NO1') AND NOT wh_proc_type IN ('8091', '8099', '9999') 
						OR STARTSWITH(dest_strg_bin, 'P2-NO1') AND wh_proc_type = '8091' AND NOT STARTSWITH(src_strg_bin, 'HF') 
						THEN 4
					WHEN STARTSWITH(src_strg_bin, 'F1-IP2') AND STARTSWITH(dest_strg_bin, 'F1-PD1') 
						OR STARTSWITH(src_strg_bin, 'B1-IP2') AND STARTSWITH(dest_strg_bin, 'B1-PD1') 
						OR STARTSWITH(src_strg_bin, 'F1-IP2') AND STARTSWITH(dest_strg_bin, 'F1-PD1') 
						OR (STARTSWITH(src_strg_bin, 'F1-IP1') AND STARTSWITH(dest_strg_bin, 'F1-IP2')
							OR STARTSWITH(src_strg_bin, 'F1-IP1') AND STARTSWITH(dest_strg_bin, 'F1-NO1')
							OR STARTSWITH(src_strg_bin, 'B1-IP1') AND STARTSWITH(dest_strg_bin, 'B1-IP2')
							OR STARTSWITH(src_strg_bin, 'B1-IP1') AND STARTSWITH(dest_strg_bin, 'B1-NO1')
							)
							AND NOT (STARTSWITH(dest_hu, '3') AND NVL(exc_cd, '') = 'MLOC') 
						OR dest_strg_bin LIKE ANY ('B1-IP1%', 'F1-IP1%') 
						OR wh_proc_type = '8090' AND dest_strg_bin LIKE ANY ('F1-NO1%', 'B1-NO1%') 
						OR dest_strg_bin LIKE ANY ('F1-NO1%', 'B1-NO1%') AND wh_proc_type = '8091' 
						THEN 5
					WHEN STARTSWITH(src_strg_bin, 'B2-IP2') AND STARTSWITH(dest_strg_bin, 'B2-PD1') 
						OR STARTSWITH(src_strg_bin, 'B2-IP1') AND dest_strg_bin LIKE ANY ('B2-IP2%', 'B2-NO1%') AND NOT (STARTSWITH(dest_hu, '3') AND NVL(exc_cd, '') = 'MLOC') 
						OR STARTSWITH(dest_strg_bin, 'B2-IP1') 
						OR STARTSWITH(dest_strg_bin, 'B2-NO1') AND wh_proc_type = '8090' 
						OR STARTSWITH(dest_strg_bin, 'B2-NO1') AND wh_proc_type = '8091' 
						THEN 6
					WHEN REGEXP_LIKE(dest_strg_bin, 'OB-OF1-0[1|2|3|4].*') 
						THEN 9
					ELSE 99
				END,
			(8, 6),
				CASE 
					WHEN STARTSWITH(src_strg_bin, 'IB-IP2-01') AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR STARTSWITH(src_strg_bin, 'IB-IP2') AND STARTSWITH(dest_strg_bin, 'HF') 
						OR dest_strg_bin LIKE ANY ('IB-IP2%', 'DI-IPN_2%') AND NVL(exc_cd, '') <> 'MLOC' 
						OR STARTSWITH(dest_strg_bin, 'DI-NO1') 
							AND NOT (wh_proc_type IN ('8099', '9999') 
								OR wh_proc_type = '8090' AND src_strg_bin LIKE ANY ('DI-IPN_2%', 'DI-IPT%')
								OR wh_proc_type = '8091' AND NOT STARTSWITH(src_strg_bin, 'HF')
								) 
                        OR (src_strg_bin LIKE 'IB-%' AND dest_strg_bin = 'DI-OF1-01') 
						THEN 1
					WHEN src_strg_bin LIKE ANY ('DI-IP2%', 'DI-IPN_2-01%', 'DI-IPT-01%') AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR src_strg_bin LIKE ANY ('DI-IP2%', 'DI-IPN_2%') AND STARTSWITH(dest_strg_bin, 'HF') 
						OR dest_strg_bin LIKE ANY ('DI-IP2%', 'DI-IPT%') AND NVL(exc_cd, '') <> 'MLOC' 
						OR src_strg_type = '8180'
							AND (STARTSWITH(dest_strg_bin, 'DI-NO1') AND wh_proc_type = '8091' AND NOT STARTSWITH(src_strg_bin, 'HF')
								OR STARTSWITH(dest_strg_bin, 'DI-OF1') AND wh_proc_type = '8091' AND NOT STARTSWITH(src_strg_bin, 'HF')
								OR STARTSWITH(dest_strg_bin, 'DI-NO1') AND wh_proc_type = '8090' AND STARTSWITH(src_strg_bin, 'DI-IPN_2')
								OR STARTSWITH(dest_strg_bin, 'DI-NO1') AND wh_proc_type = '8090' AND STARTSWITH(src_strg_bin, 'DI-IPT')
								) 
                        OR (src_strg_bin LIKE 'DI-%' AND dest_strg_bin = 'DI-OF1-1') 
						THEN 2
					WHEN REGEXP_LIKE(dest_strg_bin, 'OB-OF1-0[1|2|3].*') 
						THEN 9
					ELSE 99
				END,
			(10, 7), 
				CASE 
					WHEN STARTSWITH(src_strg_bin, 'IB-IP2') AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR dest_strg_bin LIKE ANY ('IB-IP2%', 'OB-IP2-%') 
						OR dest_strg_bin LIKE ANY ('IB-NO1%', 'OB-NO1-%', 'OB-CHK-%', 'IB-OF1-1') 
						OR src_strg_bin LIKE ANY ('IB-IP2%', 'OB-IP2-%') AND dest_strg_bin LIKE ANY ('HF%', 'OB-OF%') 
                        OR (src_strg_bin LIKE 'IB-%' AND dest_strg_bin = 'IB-OF1-2' ) 
						THEN 1
					WHEN src_strg_bin = 'DI-IP2-1' AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR STARTSWITH(dest_strg_bin, 'DI-IP2') 
						OR STARTSWITH(dest_strg_bin, 'DI-NO1') 
						OR STARTSWITH(src_strg_bin, 'DI-IP2') AND STARTSWITH(dest_strg_bin, 'OB-OF') 
                        OR (src_strg_bin LIKE 'DI-%' AND dest_strg_bin = 'DI-OF1-1') 
						THEN 2
					WHEN src_strg_bin = 'P1-IP2-1' AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR STARTSWITH(dest_strg_bin, 'P1-IP2') 
						OR STARTSWITH(src_strg_bin, 'P1-IP1') 
						OR STARTSWITH(dest_strg_bin, 'P1-NO1') 
						OR STARTSWITH(src_strg_bin, 'P1-IP2') AND STARTSWITH(dest_strg_bin, 'OB-OF') 
						THEN 3
					WHEN src_strg_bin = 'P2-IP2-1' AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR STARTSWITH(dest_strg_bin, 'P2-IP2') 
						OR STARTSWITH(src_strg_bin, 'P2-IP1') 
						OR STARTSWITH(dest_strg_bin, 'P2-NO1') 
						OR STARTSWITH(src_strg_bin, 'P2-IP2') AND STARTSWITH(dest_strg_bin, 'OB-OF') 
						THEN 4
					WHEN STARTSWITH(src_strg_bin, 'B1-IP2') 
						OR STARTSWITH(dest_strg_bin, 'B1-IP1') 
						OR STARTSWITH(src_strg_bin, 'B1-IP1') 
						OR STARTSWITH(dest_strg_bin, 'B1-NO1') 
						THEN 5
					WHEN STARTSWITH(src_strg_bin, 'B2-IP2') 
						OR STARTSWITH(dest_strg_bin, 'B2-IP1') 
						OR STARTSWITH(src_strg_bin, 'B2-IP1') 
						OR STARTSWITH(dest_strg_bin, 'B2-NO1') 
						THEN 6
					WHEN STARTSWITH(dest_strg_bin, 'N1-IP2') AND NVL(exc_cd, '') <> 'MLOC' 
						OR STARTSWITH(src_strg_bin, 'N1-IP2') AND STARTSWITH(dest_strg_bin, 'HF') OR STARTSWITH(dest_strg_bin, 'OB-OF1')   
						OR STARTSWITH(dest_strg_bin, 'N1-NO1-%') AND wh_proc_type = '8091' 
						OR wh_proc_type = '8091' AND src_strg_bin LIKE 'HF-%' AND dest_strg_bin LIKE 'N1-NO1-%%'
						OR wh_proc_type NOT IN ('8099', '9999') AND dest_strg_bin LIKE 'N1-NO1-%%'
						THEN 7
					WHEN REGEXP_LIKE(dest_strg_bin, 'OB-OF1-0[1|2|3|4]') 
						THEN 9
					WHEN STARTSWITH(dest_strg_bin, 'F1-OF1') 
						THEN 10
					ELSE 99
				END,
			(18, 4),
				CASE 
					WHEN STARTSWITH(src_strg_bin, 'IB-IP2') AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR dest_strg_bin LIKE 'IB-IP2%' AND NVL(exc_cd, '') <> 'MLOC' 
						OR src_strg_bin LIKE 'IB-IP2%' AND dest_strg_bin LIKE ANY ('HF%', 'OB-OF1%') 
						OR dest_strg_bin LIKE 'IB-NO1%' AND src_strg_bin <> 'HF%' AND wh_proc_type = '8091' 
						OR dest_strg_bin LIKE 'OB-CHK%' AND wh_proc_type = '8091' 
						OR dest_strg_bin LIKE ANY ('IB-NO1%', 'OB-CHK%') AND wh_proc_type = '8091' AND wh_proc_type NOT IN ('8099', '9999') 
                        OR (src_strg_bin LIKE 'IB%' AND dest_strg_bin = 'IB-OF1-01') 
						THEN 1
					WHEN src_strg_bin = 'P1-IP2-1' AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR dest_strg_bin LIKE 'P1-IP1%' AND NVL(exc_cd, '') <> 'MLOC' 
						OR STARTSWITH(src_strg_bin, 'P1-IP1') AND dest_strg_bin LIKE 'P1-IP2%' 
						OR STARTSWITH(src_strg_bin, 'P1-IP2') AND dest_strg_bin LIKE ANY  ('HF%', 'OB-OF1%', 'F1-OF1%') 
						OR dest_strg_bin LIKE ANY ('P1-NO1%', 'OB-CHK') AND wh_proc_type = '8091' 
						OR dest_strg_bin LIKE ANY ('P1-NO1', 'OB-CHK') AND wh_proc_type NOT IN ('8091', '8099', '9999') 
						THEN 3
					WHEN src_strg_bin = 'P2-IP2-1' AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR dest_strg_bin LIKE 'P2-IP1%' AND NVL(exc_cd, '') <> 'MLOC' 
						OR STARTSWITH(src_strg_bin, 'P2-IP1') AND dest_strg_bin LIKE 'P2-IP2%' 
						OR STARTSWITH(src_strg_bin, 'P2-IP2') AND dest_strg_bin LIKE ANY  ('HF%', 'OB-OF1%', 'F1-OF1%') 
						OR dest_strg_bin LIKE ANY ('P2-NO1%', 'OB-CHK') AND wh_proc_type = '8091' 
						OR dest_strg_bin LIKE ANY ('P2-NO1', 'OB-CHK') AND wh_proc_type NOT IN ('8091', '8099', '9999') 
						THEN 4
					WHEN STARTSWITH(src_strg_bin, 'B1-IP2') 
						OR dest_strg_bin LIKE 'B1-IP1-%' AND NVL(exc_cd, '') <> 'MLOC' 
						OR STARTSWITH(src_strg_bin, 'B1-IP1') AND dest_strg_bin LIKE 'B1-NO1%' 
						OR dest_strg_bin LIKE 'B1-PD1%' 
						OR dest_strg_bin LIKE 'B1-NO1%' AND wh_proc_type = '8091' 
						OR dest_strg_bin LIKE 'B1-NO1' 
						THEN 5
					WHEN STARTSWITH(src_strg_bin, 'B2-IP2') 
						OR dest_strg_bin LIKE 'B2-IP1-%' AND NVL(exc_cd, '') <> 'MLOC' 
						OR STARTSWITH(src_strg_bin, 'B2-IP1') AND dest_strg_bin LIKE 'B2-NO1%' 
						OR dest_strg_bin LIKE 'B2-PD1%' 
						OR dest_strg_bin LIKE 'B2-NO1%' AND wh_proc_type = '8091' 
						OR dest_strg_bin LIKE 'B2-NO1' 
						THEN 6
					WHEN REGEXP_LIKE(dest_strg_bin, 'OB-OF1-0[1|2|3|4]') 
						THEN 9
					WHEN STARTSWITH(dest_strg_bin, 'F1-OF1') 
						THEN 10
					ELSE 99
				END,
			(25, 96),
				CASE 
					WHEN src_strg_bin LIKE ANY ('IB-IP2%', 'IB-IPN_2%') AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR src_strg_bin LIKE ANY ('IB-IP2%', 'IB-IPN_2%') AND STARTSWITH(dest_strg_bin, 'HF') 
						OR dest_strg_bin LIKE ANY ('IB-IP2%', 'IB-IPN_2%') AND NVL(exc_cd, '') <> 'MLOC' 
						OR (STARTSWITH(dest_strg_bin, 'IB-NO1') 
							AND NOT (wh_proc_type IN ('8099', '9999')
								OR wh_proc_type = '8090' AND STARTSWITH(src_strg_bin, 'IB-IPN_2') 
								OR wh_proc_type = '8091' AND NOT STARTSWITH(src_strg_bin, 'HF') 
								)
							) 
						OR (STARTSWITH(dest_strg_bin, 'DI-NO1') 
							AND NOT (wh_proc_type IN ('8099', '9999')
								OR wh_proc_type = '8091' AND NOT STARTSWITH(src_strg_bin, 'HF') 
								)
							) 
						OR src_strg_type = '8180'
							AND (STARTSWITH(dest_strg_bin, 'IB-NO1') AND wh_proc_type = '8091' AND NOT STARTSWITH(src_strg_bin, 'HF') AND src_strg_bin LIKE 'IB-%'
								OR STARTSWITH(dest_strg_bin, 'IB-OF1') AND wh_proc_type = '8091' AND NOT STARTSWITH(src_strg_bin, 'HF') AND src_strg_bin LIKE 'IB-%')
								OR STARTSWITH(dest_strg_bin, 'IB-NO1') AND wh_proc_type = '8090' AND STARTSWITH(src_strg_bin, 'IB-IPN_2') 
                        OR (src_strg_bin LIKE 'IB-%' AND dest_strg_bin = 'IB-OF1-01' ) 
						THEN 1
					WHEN STARTSWITH(src_strg_bin, 'DI-IP2') AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR src_strg_bin LIKE ANY ('DI-IP2%', 'DI-IPN_2%') AND STARTSWITH(dest_strg_bin, 'HF') 
						OR STARTSWITH(dest_strg_bin, 'DI-IP2') AND NVL(exc_cd, '') <> 'MLOC' 
						OR src_strg_type = '8180'
							AND (STARTSWITH(dest_strg_bin, 'IB-NO1') AND wh_proc_type = '8091' AND NOT STARTSWITH(src_strg_bin, 'HF') AND src_strg_bin LIKE 'DI-%'
								OR STARTSWITH(dest_strg_bin, 'DI-OF1') AND wh_proc_type = '8091' AND NOT STARTSWITH(src_strg_bin, 'HF') AND src_strg_bin LIKE 'DI-%')
								OR STARTSWITH(dest_strg_bin, 'DI-NO1') AND wh_proc_type = '8090' AND STARTSWITH(src_strg_bin, 'DI-IPN_2') 
                        OR (src_strg_bin LIKE 'DI-%' AND dest_strg_bin = 'IB-OF1-01') 
						THEN 2
					WHEN REGEXP_LIKE(dest_strg_bin, 'OB-OF1-0[1|2|3].*') 
						THEN 9
					WHEN STARTSWITH(dest_strg_bin, 'OB-PM1-01') 
						THEN 11
					ELSE 99
				END,
            (13, 60),
				CASE                 
					WHEN STARTSWITH(src_strg_bin, 'IB-IP2%') AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR dest_strg_bin LIKE ('IB-IP2-%') AND NVL(exc_cd, '') <> 'MLOC' 
						OR src_strg_bin LIKE  ('IB-IP2-%') AND dest_strg_bin LIKE ('HF%') 
                        OR wh_proc_type = '8091' AND src_strg_type = '8180' AND NOT src_strg_bin LIKE ('HF%') AND (dest_strg_bin LIKE 'IB-NO1-%' OR dest_strg_bin LIKE 'IB-OF1-%') AND src_strg_bin LIKE 'IB%' 
						OR dest_strg_bin LIKE ('%IB-NO1-%') AND wh_proc_type NOT IN ('8099', '9999') AND src_strg_bin LIKE ('IB-IP2-%')  
                        OR dest_strg_bin LIKE ('%IB-NO1-%') AND wh_proc_type = '8091' AND src_strg_bin LIKE ('HF%') 
                        OR (src_strg_bin LIKE 'IB%' AND dest_strg_bin = 'IB-OF1-01') 
						THEN 1
                        
                    WHEN STARTSWITH(src_strg_bin, 'DI-IP%') AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR dest_strg_bin LIKE ANY ('DI-IP2-%') AND NVL(exc_cd, '') <> 'MLOC' 
						OR src_strg_bin LIKE ANY ('DI-IP2-%') AND dest_strg_bin LIKE ('HF%') 
                        OR wh_proc_type = '8091' AND src_strg_type = '8180' AND NOT src_strg_bin LIKE ('HF%') AND (dest_strg_bin LIKE 'IB-NO1-%' OR dest_strg_bin LIKE 'IB-OF1-%') AND src_strg_bin LIKE 'DI%' 
						OR dest_strg_bin LIKE ANY ('%IB-NO1-%') AND wh_proc_type NOT IN ('8099', '9999') AND src_strg_bin LIKE ('DI-IP2-%')  
                        OR dest_strg_bin LIKE ANY ('%IB-NO1-%') AND wh_proc_type = '8091' 
                        OR (src_strg_bin LIKE 'DI%' AND dest_strg_bin = 'DI-OF1-01') 
						THEN 2
                        
					WHEN STARTSWITH(src_strg_bin, 'N1-IP2%') AND wh_proc_type = '8090' AND STARTSWITH(dest_strg_bin, 'HF') 
						OR dest_strg_bin LIKE 'N1-IP2-%' AND NVL(exc_cd, '') <> 'MLOC' 
						OR STARTSWITH(src_strg_bin, 'N1-IP2') AND dest_strg_bin LIKE ('HF%') 
						OR wh_proc_type = '8091' AND dest_strg_bin LIKE ('N1-NO1%') 
						OR dest_strg_bin LIKE ('N1-NO1') AND wh_proc_type NOT IN ('8099', '9999') 
                        OR dest_strg_bin LIKE ('N1-NO1') AND wh_proc_type = '8091' AND src_strg_bin LIKE 'HF%' 
						OR (src_strg_bin LIKE 'N1%' AND dest_strg_bin = 'N1-OF1-01') 
						THEN 7
					WHEN REGEXP_LIKE(dest_strg_bin, 'OB-OF1-0[1|2|3|4]') 
						THEN 9
					WHEN STARTSWITH(dest_strg_bin, 'F1-OF1') 
						THEN 10
					ELSE 99
                END,
			(23, 18),
				CASE 
					WHEN NVL(exc_cd, '') <> 'MLOC'  
						THEN 2
					ELSE 99		
				END,
			NULL) AS conveyor_id		
		,CASE 
			WHEN 
				((wht.client_id, wht.wh_id) = (1, 9) 
					AND (dest_strg_bin LIKE ANY ('IB-IP2-%', 'DI-IP2-%') AND NVL(exc_cd, '') != 'MLOC' 
						OR dest_strg_bin LIKE 'P2-IP1-%' AND STARTSWITH(src_hu, '3') AND NVL(exc_cd, '') != 'MLOC' 
						OR src_strg_bin LIKE 'P2-IP1-%' AND dest_strg_bin LIKE 'P2-NO1-%' AND STARTSWITH (src_hu, '9') 
						OR dest_strg_bin LIKE ANY ('F1-IP1-%', 'B1-IP1-%', 'B2-IP1-%') AND STARTSWITH(src_hu, '3') AND NVL(exc_cd, '') != 'MLOC' 
						OR src_strg_bin LIKE ANY ('F1-IP1-%', 'B1-IP1-%', 'B2-IP1-%') AND dest_strg_bin LIKE ANY ('F1-NO1-%', 'B1-NO1-%', 'B2-NO1-%' ) AND STARTSWITH(src_hu, '9') 
						)
					)
				OR ((wht.client_id, wht.wh_id) = (8, 6) 
					AND dest_strg_bin LIKE ANY ('IB-IP2-%', 'DI-IPN_2-%', 'DI-IPT-%', 'DI-IP2-%') AND NVL(exc_cd, '') != 'MLOC'
					)
				OR ((wht.client_id, wht.wh_id) = (10, 7) 
					AND (dest_strg_bin LIKE ANY ('OB-IP2-%', 'IB-IP2-%', 'DI-IP2-%') AND NVL(exc_cd, '') != 'MLOC'
						OR src_strg_bin LIKE 'DI-IP1-%' AND dest_strg_bin = 'DI-OF1-01'
						OR dest_strg_bin LIKE ANY ('P1-IP2-%', 'P2-IP2-%') AND STARTSWITH(src_hu, '3') AND NVL(exc_cd, '') != 'MLOC' 
						OR src_strg_bin LIKE ANY ('P1-IP1-%', 'P2-IP1-%') AND dest_strg_bin LIKE ANY ('P1-NO1-%', 'P2-NO1-%') AND STARTSWITH(src_hu, '9')
						OR dest_strg_bin LIKE ANY ('B1-IP1-%', 'B2-IP1-%') AND STARTSWITH(src_hu, '3') AND NVL(exc_cd, '') != 'MLOC' 
						OR src_strg_bin LIKE ANY ('B1-IP1-%', 'B2-IP1-%') AND dest_strg_bin LIKE ANY ('B1-NO1-%', 'B2-NO1-%') AND STARTSWITH(src_hu, '9') 
						OR dest_strg_bin LIKE 'N1-IP2-%' AND NVL(exc_cd, '') != 'MLOC' 
						)
					)
				OR ((wht.client_id, wht.wh_id) = (18, 4)
					AND (dest_strg_bin LIKE ANY 'IB-IP2-%' AND NVL(exc_cd, '') != 'MLOC' 
						OR dest_strg_bin LIKE ANY ('P1-IP1-%', 'P2-IP1-%') AND STARTSWITH(src_hu, '3') AND NVL(exc_cd, '') != 'MLOC' 
						OR src_strg_bin LIKE ANY ('P1-IP1-%', 'P2-IP1-%') AND dest_strg_bin LIKE ANY ('P1-IP2-%', 'P2-IP2-%') AND STARTSWITH(src_hu, '9') 
						OR dest_strg_bin LIKE ANY ('B1-IP1-%', 'B2-IP1-%') AND STARTSWITH(src_hu, '3') AND NVL(exc_cd, '') != 'MLOC' 
						OR src_strg_bin LIKE ANY ('B1-IP1-%', 'B2-IP1-%') AND dest_strg_bin LIKE ANY ('B1-NO1-%', 'B2-NO1-%') AND STARTSWITH(src_hu, '9') 
						)
					)
				OR ((wht.client_id, wht.wh_id) = (23, 18) 
					AND src_strg_bin LIKE ANY ('TI-IP1-%')
					)
				OR ((wht.client_id, wht.wh_id) = (25, 96) 
					AND dest_strg_bin LIKE ANY ('IB-IP2-%', 'DI-IP2-%', 'IB-IPN_2-%', 'DI-IPN_2-%') AND NVL(exc_cd, '') != 'MLOC'
					)
                OR ((wht.client_id, wht.wh_id) = (13, 60) 
					AND dest_strg_bin LIKE ANY ('IB-IP2-%', 'DI-IP2-%') AND NVL(exc_cd, '') != 'MLOC' 
                    OR dest_strg_bin LIKE ('N1-IP2-%') AND NVL(exc_cd, '') != 'MLOC' 
					)
				THEN 1
				ELSE 0
			END AS hu_checked
		,CASE 
			WHEN 
				((wht.client_id, wht.wh_id) = (1, 9) 
					AND (src_strg_bin LIKE ANY ('IB-IP2-%', 'DI-IP2-%') AND dest_strg_bin LIKE ANY ('HF-%', 'OB-OF%', 'RL-OF1-01')
						OR src_strg_bin LIKE 'P2-IP2-%' AND dest_strg_bin LIKE ANY ('HF-%', 'OB-OF%', 'RL-OF1-01') 
						OR src_strg_bin LIKE ANY ('F1-IP2-%', 'B1-IP2-%', 'B2-IP2-%') AND dest_strg_bin LIKE ANY ('F1-PD1-%', 'B1-PD1-%', 'B2-PD1-%') 
						)
					)
				OR ((wht.client_id, wht.wh_id) = (8, 6) 
					AND src_strg_bin LIKE ANY ('IB-IP2-%', 'DI-IP2-%', 'IB-IPN_2-%', 'DI-IPN_2-%') AND dest_strg_bin LIKE 'HF-%'
					)
				OR ((wht.client_id, wht.wh_id) = (10, 7) 
					AND (src_strg_bin LIKE ANY ('IB-IP2-%', 'DI-IP2-%', 'OB-IP2-%') AND dest_strg_bin LIKE ANY ('HF-%', 'OB-OF%')
						OR src_strg_bin LIKE ANY ('P1-IP2-%', 'P2-IP2-%') AND dest_strg_bin LIKE ANY ('HF-%', 'OB-OF%') 
						OR src_strg_bin LIKE ANY ('B1-IP2-%', 'B2-IP2-%') AND dest_strg_bin LIKE ANY ('B1-PD1-%', 'B2-PD1-%') 
						OR src_strg_bin LIKE 'N1-IP2-%' AND dest_strg_bin LIKE ANY ('HF-%', 'OB-OF%') 
						)
					)
				OR ((wht.client_id, wht.wh_id) = (18, 4) 
					AND (src_strg_bin LIKE 'IB-IP2-%' AND dest_strg_bin LIKE ANY ('HF-%', 'OB-OF1-%') 
						OR src_strg_bin LIKE ANY ('P1-IP2-%', 'P2-IP2-%') AND dest_strg_bin LIKE ANY ('HF-%', 'OB-OF1-%', 'F1-OF1-%') 
						OR src_strg_bin LIKE ANY ('B1-IP2-%', 'B2-IP2-%') AND dest_strg_bin LIKE ANY ('B1-PD1%', 'B2-PD1%') 
						)
					)
				OR ((wht.client_id, wht.wh_id) = (23, 18) 
					AND src_strg_bin LIKE ANY ('TI-IP2-%') AND dest_strg_bin LIKE 'TI-PC%'
					)
				OR ((wht.client_id, wht.wh_id) = (25, 96) 
					AND src_strg_bin LIKE ANY ('IB-IP2-%', 'DI-IP2-%', 'IB-IPN_2-%', 'DI-IPN_2-%') AND dest_strg_bin LIKE 'HF-%'
					)
                OR ((wht.client_id, wht.wh_id) = (13, 60) 
					AND src_strg_bin LIKE ANY ('IB-IP2-%', 'DI-IP2-%') AND dest_strg_bin LIKE 'HF-%' 
                    OR src_strg_bin LIKE ('N1-IP2-%') AND dest_strg_bin LIKE 'HF-%' 
					)
				THEN 1
				ELSE 0
			END AS hu_passed
		,CASE
			WHEN (
				(wht.client_id, wht.wh_id) = (1, 9) 
					AND ( 
						(dest_strg_bin LIKE ANY ('IB-NO1-%', 'DI-NO1-%') AND wh_proc_type = '8091' AND src_strg_bin != 'IB-SCN-01' AND NOT src_strg_bin LIKE 'HF-%')
						OR 
							(dest_strg_bin LIKE 'P2-NO1-%' AND wh_proc_type = '8091')
						OR 
							(dest_strg_bin LIKE ANY ('F1-NO1-%', 'B1-NO1-%', 'B2-NO1-%') AND wh_proc_type = '8091')  
						)
					)
				OR ((wht.client_id, wht.wh_id) = (25, 96) 
					AND (
						(dest_strg_bin LIKE ANY ('IB-NO1-%', 'DI-NO1-%', 'IB-OF1-01') 
							AND wh_proc_type = '8091' AND SRC_STRG_TYPE = '8180' AND NOT src_strg_bin LIKE 'HF-%')
						OR (wh_proc_type = '8090' 
							AND ((dest_strg_bin LIKE 'IB-NO1-%' AND src_strg_bin LIKE 'IB-IPN_2-%') 
								OR (dest_strg_bin LIKE 'DI-NO1-%' AND src_strg_bin LIKE 'DI-IPN_2-%') 
								)
							)
						)
					)
				OR ((wht.client_id, wht.wh_id) = (8, 6) 
					AND (
						(dest_strg_bin LIKE ANY ('IB-NO1-%', 'DI-NO1-%', 'DI-OF1-01') 
							AND wh_proc_type = '8091' AND src_strg_type = '8180' AND NOT src_strg_bin LIKE 'HF-%')
						OR (wh_proc_type = '8090' 
							AND ((dest_strg_bin LIKE 'IB-NO1-%' AND src_strg_bin LIKE ANY ('IB-IPN_2-%', 'IB-IPT-%'))
								OR (dest_strg_bin LIKE 'DI-NO1-%' AND src_strg_bin LIKE ANY ('DI-IPN_2-%', 'DI-IPT-%'))
								)
							)
						)
					)
				OR ((wht.client_id, wht.wh_id) = (10, 7) 
					AND (
						((dest_strg_bin LIKE ANY ('IB-NO1-%', 'DI-NO1-%', 'OB-NO1-%', 'IB-OF1-1') AND wh_proc_type = '8091' AND NOT src_strg_bin LIKE 'HF-%')
							OR (wh_proc_type = '8091' AND src_strg_bin LIKE 'OB-IP2-%' AND dest_strg_bin LIKE 'OB-CHK-%')
							)
						
						OR (wh_proc_type = '8091' 
								AND	(dest_strg_bin LIKE ANY ('P1-NO1-%', 'P2-NO1-%') 
									OR (dest_strg_bin LIKE 'OB-CHK-%' AND wh_proc_type = '8091' AND src_strg_bin LIKE 'P1-IP2-%'))
							)
						
						OR (dest_strg_bin LIKE ANY ('B1-NO1-%', 'B2-NO1-%') AND wh_proc_type = '8091')
						
						OR (dest_strg_bin LIKE 'N1-NO1-%' AND wh_proc_type = '8091')
						)   
					)
				OR ((wht.client_id, wht.wh_id) = (18, 4) 
					AND (
						((dest_strg_bin LIKE 'IB-NO1-%' AND wh_proc_type = '8091' AND NOT src_strg_bin LIKE 'HF-%')
							OR (wh_proc_type = '8091' AND src_strg_bin LIKE 'IB-IP2-%' AND dest_strg_bin LIKE 'OB-CHK-%')
							)
						
						OR (wh_proc_type = '8091' 
								AND	(dest_strg_bin LIKE ANY ('P1-NO1-%', 'P2-NO1-%') 
									OR (dest_strg_bin LIKE 'OB-CHK-%' AND wh_proc_type = '8091' AND src_strg_bin LIKE ANY ('P1-IP2-%', 'P2-IP2-%')))
							)
						
						OR (dest_strg_bin LIKE ANY ('B1-NO1-%', 'B2-NO1-%') AND wh_proc_type = '8091')
						)   
					) 
                OR ((wht.client_id, wht.wh_id) = (13, 60) 
					AND (
						(wh_proc_type = '8091' AND src_strg_type = '8180' AND NOT src_strg_bin LIKE ('HF%') AND (dest_strg_bin LIKE 'IB-NO1-%' OR dest_strg_bin LIKE 'IB-OF1-%') AND src_strg_bin LIKE 'IB%')
                        OR (wh_proc_type = '8091' AND src_strg_type = '8180' AND NOT src_strg_bin LIKE ('HF%') AND (dest_strg_bin LIKE 'IB-NO1-%' OR dest_strg_bin LIKE 'IB-OF1-%') AND src_strg_bin LIKE 'DI%')
                        OR 
                        (wh_proc_type = '8091' AND dest_strg_bin LIKE ('N1-NO1%'))
					    ))
				OR ((wht.client_id, wht.wh_id) = (23, 18) 
					AND ( 
						(dest_strg_bin LIKE '%-NO1-%' AND wh_proc_type = '8291' AND NOT src_strg_bin LIKE 'TI-SC1%' AND NOT src_strg_bin LIKE 'TF-%') 
						)
					)
				THEN 1
				ELSE 0
			END AS nio_count 
		,CASE
			WHEN ((wht.client_id, wht.wh_id) = (1, 9) 
					AND ( 
						(dest_strg_bin LIKE ANY ('IB-NO1-%', 'DI-NO1-%')
							AND NOT ((wh_proc_type = '8091' AND NOT src_strg_bin LIKE 'HF-%') OR (wh_proc_type IN ('8099', '9999'))))
						OR 
							(dest_strg_bin LIKE 'P2-NO1-%' AND NOT (wh_proc_type IN ('8091', '8099', '9999')))
						OR 
							(dest_strg_bin LIKE ANY ('F1-NO1-%','B1-NO1-%' ,'B2-NO1-%') AND wh_proc_type = '8090')  
						)
				) 
				OR ((wht.client_id, wht.wh_id) = (25, 96) 
					AND (
						(dest_strg_bin LIKE 'IB-NO1-%' 
           					AND NOT ( (wh_proc_type = '8091' AND NOT src_strg_bin LIKE 'HF-%') 
                 					OR (wh_proc_type IN ('8099', '9999') OR (wh_proc_type = '8090' AND NOT src_strg_bin LIKE 'IB-IPN_2%') )
									)
						)
						OR (dest_strg_bin LIKE 'DI-NO1-%' 
							AND NOT ( (wh_proc_type = '8091' AND NOT src_strg_bin LIKE 'HF-%') 
                 					OR (wh_proc_type IN ('8099', '9999') 
									 	OR (wh_proc_type = '8090' AND NOT src_strg_bin LIKE 'DI-IPN_2%') 
										)
									)
							)
						)
				) 
				OR ((wht.client_id, wht.wh_id) = (8, 6) 
					AND (
						(dest_strg_bin LIKE 'IB-NO1-%' 
							AND NOT ((wh_proc_type = '8091' AND NOT src_strg_bin LIKE 'HF-%') 
								OR (wh_proc_type IN ('8099', '9999')
								
								)
							)
						)
						OR (dest_strg_bin LIKE 'DI-NO1-%' 
							AND NOT ((wh_proc_type = '8091' AND NOT src_strg_bin LIKE 'HF-%') 
								OR (wh_proc_type IN ('8099', '9999') 
								
								)
							)
						)
					)
					)
				OR ((wht.client_id, wht.wh_id) = (10, 7) 
					AND (
						(dest_strg_bin LIKE ANY ('IB-NO1-%', 'DI-NO1-%', 'OB-NO1-%', 'OB-CHK-%') 
							AND NOT ((wh_proc_type = '8091' AND NOT src_strg_bin LIKE 'HF-%') OR wh_proc_type IN ('8099', '9999'))
							)
						
						OR (dest_strg_bin LIKE ANY ('P1-NO1-%', 'P2-NO1-%', 'OB-CHK-%') 
							AND NOT ((wh_proc_type = '8091' AND NOT src_strg_bin LIKE 'HF-%') OR wh_proc_type IN ('8091', '8099', '9999'))
							)
						
						OR (dest_strg_bin LIKE ANY ('B1-NO1-%', 'B2-NO1-%') AND wh_proc_type = '8090')
						
						OR (dest_strg_bin LIKE 'N1-NO1-%' AND NOT ((wh_proc_type = '8091' AND NOT src_strg_bin LIKE 'HF-%') OR (wh_proc_type IN ('8099', '9999'))))
						)   
					)
				OR ((wht.client_id, wht.wh_id) = (18, 4) 
					AND (
						(dest_strg_bin LIKE ANY ('IB-NO1-%', 'OB-CHK-%') AND wh_proc_type = '8091' AND src_strg_bin LIKE 'HF-%'
							AND wh_proc_type NOT IN ('8099', '9999')
							)
						
						OR (dest_strg_bin LIKE ANY ('P1-NO1-%', 'P2-NO1-%', 'OB-CHK-%')
							AND wh_proc_type NOT IN ('8091', '8099', '9999')
							)
						
						OR ((dest_strg_bin LIKE ANY ('B1-NO1-%', 'B2-NO1-%') AND wh_proc_type = '8090'))
							)		
					)
                OR ((wht.client_id, wht.wh_id) = (13, 60) 
					AND (
						(dest_strg_bin LIKE ('%IB-NO1-%') AND wh_proc_type = '8091' AND src_strg_bin LIKE 'HF-%')
                        OR (dest_strg_bin LIKE ('%IB-NO1-%') AND wh_proc_type NOT IN ('8099', '9999'))
							) 
						OR (dest_strg_bin LIKE ('N1-NO1-%')
							AND wh_proc_type NOT IN ('8099', '9999')
							)
						OR (dest_strg_bin LIKE ('N1-NO1-%')
							AND wh_proc_type IN ('8091') AND src_strg_bin LIKE ('HF-%')
							)		
					)
				OR ((wht.client_id, wht.wh_id) = (23, 18) 
					AND (
						(dest_strg_bin LIKE ('%-NO1-%') AND wh_proc_type = '8291' AND NOT src_strg_bin LIKE 'TF-%')
                        OR (dest_strg_bin LIKE ('%-NO1-%') AND wh_proc_type NOT IN ('8289', '9999'))
							) 	
					) 	
				THEN 1
				ELSE 0
			END AS nio_sonstige
		,CASE  
			WHEN 
				((wht.client_id, wht.wh_id) = (1, 9) 
					AND ((src_strg_bin LIKE 'IB-%' AND dest_strg_bin LIKE 'IB-OF1-01')
						OR (src_strg_bin LIKE 'DI-%' AND dest_strg_bin LIKE 'RL-OF1-01')
						)
					)
				OR ((wht.client_id, wht.wh_id) = (25, 96) 
					AND ((src_strg_bin LIKE 'IB-%' AND dest_strg_bin LIKE 'IB-OF1-01' )
						OR (src_strg_bin LIKE 'DI-%' AND dest_strg_bin LIKE 'IB-OF1-01')
						)
					)
				OR ((wht.client_id, wht.wh_id) = (8, 6) 
					AND ((src_strg_bin LIKE 'IB-%' AND dest_strg_bin LIKE 'DI-OF1-01')
						OR (src_strg_bin LIKE 'DI-%' AND dest_strg_bin LIKE 'DI-OF1-01')
						)
					)
				OR ((wht.client_id, wht.wh_id) = (10, 7) 
					AND ((src_strg_bin LIKE 'IB-%' AND dest_strg_bin LIKE 'IB-OF1-2') 
						OR (src_strg_bin LIKE 'DI-%' AND dest_strg_bin LIKE 'DI-OF1-1')
						)
					)
				OR ((wht.client_id, wht.wh_id) = (18, 4) 
					AND ((src_strg_bin LIKE 'IB-%' AND dest_strg_bin LIKE 'IB-OF1-01') 
						)
					)
                OR ((wht.client_id, wht.wh_id) = (13, 60) 
					AND ((src_strg_bin LIKE 'IB-%' AND dest_strg_bin LIKE 'IB-OF1-%') 
                        OR  (src_strg_bin LIKE 'DI-%' AND dest_strg_bin LIKE 'IB-OF1-%')
                        OR  (src_strg_bin LIKE 'N1-%' AND dest_strg_bin LIKE 'N1-OF1-%')
						)
					)
				OR ((wht.client_id, wht.wh_id) = (23, 18) 
					AND ((src_strg_bin NOT LIKE '%-NO1-%' AND dest_strg_bin LIKE 'TI-OF1-01' ))
					)
				THEN 1
				ELSE 0
			END AS send_out
		,CASE  
			WHEN 
				((wht.client_id, wht.wh_id) = (23, 18) 
					AND ((src_strg_bin LIKE '%-NO1-%' AND dest_strg_bin LIKE 'TI-OF1-01' ))
					)
				THEN 1
				ELSE 0
			END AS nio_send_out
	FROM DATA.T_SAPEWM_WAREHOUSETASK_2 wht 
	WHERE wht.tostat = 'C' 
		AND (wht.client_id, wht.wh_id) IN ((1, 9), (8, 6), (10, 7), (13,60), (18, 4), (23, 18), (25, 96))
		AND (hu_checked = 1 
			OR hu_passed = 1 
			OR nio_count = 1 
			OR nio_sonstige = 1 
			OR send_out = 1
			OR nio_send_out = 1
			)
	),
niohist AS (
	SELECT
	client_id
	,lidl_country AS lidl_ctry
	,source_system AS src_sys
	,wh_id
	,huident AS hu_ident
	,log_seq
    ,TO_DATE(UTC_TIMESTAMP) AS crtd_on_dt
	,cp AS com_point
	,hu_status AS hu_stat
	,hu_status_short AS hu_stat_short
	,dwh_load_id
	,dwh_created
	,dwh_updated
	FROM DATA.t_sapewm_niohistory_2
	WHERE (client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (13,60), (18, 4), (23, 18), (25, 96))
)
SELECT nio.client_id
	,nio.lidl_ctry
	,nio.wh_id
	,nio.wh_task_nr
	,nio.wh_task_item
	,nio.wh_task_stat
	,nio.wh_proc_type
	,nio.wh_proc_cat
	,nio.doc_nr
	,nio.doc_cat
	,nio.conf_dt
	,nio.conf_tm
	,nio.QUEUE
	,nio.exc_cd
	,nio.src_strg_bin
	,nio.src_hu
	,nio.src_strg_type
	,nio.src_rsrc
	,nio.dest_strg_bin
	,nio.dest_hu
	,nio.dest_strg_type
	,nio.dest_rsrc
	,nio.dwh_created
	,nio.dwh_updated
	,nh.hu_ident
	,nh.log_seq
	,nh.crtd_on_dt
	,nh.com_point
	,nh.hu_stat_short
	,CASE
     WHEN nio.client_id <> 23 THEN 
        IFF(
            nh.com_point LIKE ANY ('IB-IP1%', 'DI-IP1%', 'B1-IP1%', 'F1-IP1%', 'B2-IP1%', 'P2-IP1%', 'TI-IP1%')
            AND (nh.hu_stat_short LIKE ANY ('CLOW', 'COBE') OR nh.hu_stat_short = 'CFFR'),
            NULL,
            nh.hu_stat_short
        )
     WHEN nio.client_id = 23 THEN 
        IFF(
            nh.com_point LIKE 'TI%' AND nh.hu_stat_short IS NOT NULL,
            nh.hu_stat_short,
            NULL
        )
	 END AS err_cd 
	,ROW_NUMBER() OVER (PARTITION BY nio.client_id, nio.wh_id, nio.wh_task_nr, nio.wh_task_item ORDER BY nio.client_id, nio.wh_id, nio.wh_task_nr, nio.wh_task_item) AS row_nr	
	,IFF(row_nr = 1, nio.hu_checked, NULL) AS hu_checked
	,IFF(row_nr = 1, nio.hu_passed, NULL) AS hu_passed
	,IFF(row_nr = 1, nio.nio_count, NULL) AS nio_count
	,IFF(row_nr = 1, nio.nio_sonstige, NULL) AS nio_sonstige
	,IFF(row_nr = 1, nio.send_out, NULL) AS send_out
	,IFF(row_nr = 1, nio.nio_send_out, NULL) AS nio_send_out
	,IFF(row_nr = 1 AND (hu_checked = 1 OR hu_passed = 1 OR nio_count = 1 OR nio_sonstige = 1 OR nio.send_out=1 OR nio.nio_send_out=1 ), nio.conveyor_id, NULL) AS conveyor_id 
FROM nio 
	LEFT JOIN niohist nh 
		ON nio.client_id = nh.client_id
			AND nio.wh_id = nh.wh_id 
			AND nio.src_hu = nh.hu_ident
			AND nio.conf_dt = nh.crtd_on_dt
			AND nio.nio_count = 1 
;