/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_goodsin_stockonlane_add
Description		|	SAP EWM Goods In - view with additional columns 
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_goodsin_stockonlane_add(
	CLIENT_ID COMMENT 'Client id (PK)',
	LIDL_CTRY COMMENT 'Country code (PK)',
	WH_ID COMMENT 'Warehouse ID',
	WH_TASK_NR COMMENT 'Warehouse Task (PK)',
	WH_TASK_ITEM COMMENT 'Warehouse Task Item (PK)',
	WH_TASK_STAT COMMENT 'Warehouse Task Status - Technical name: TOSTAT - Component Type: /SCWM/DE_TOSTAT',
	WH_PROC_TYPE COMMENT 'Warehouse Process Type - Technical name: PROCTY - Component Type: /SCWM/DE_PROCTY',
	WH_PROC_CAT COMMENT 'Warehouse Process Category - Technical name: TRART - Component Type: /SCWM/LVS_TRART',
	DOC_NR COMMENT 'Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT',
	DOC_CAT COMMENT 'Document Category for Document-Related Stocks - Technical name: QDOCCAT - Component Type: /SCWM/DE_UI_QDOCCAT',
	PROD_NR COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR',
	PROD_DESC COMMENT 'Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX',
	CONF_DT COMMENT 'Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE',
	CONF_TM COMMENT 'Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME',
	CONF_TS COMMENT 'Confirmation timestamp',
	CONF_HR COMMENT 'Confirmation hour',
	HU_FG COMMENT 'Handling Unit Warehouse Task - Technical name: FLGHUTO - Component Type: /SCWM/FLGHUTO',
	SRC_STRG_BIN COMMENT 'Source Storage Bin - Technical name: VLPLA - Component Type: /SCWM/LTAP_VLPLA',
	SRC_HU COMMENT 'Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	SRC_STRG_TYPE COMMENT 'Source Storage Type - Technical name: VLTYP - Component Type: /SCWM/LTAP_VLTYP',
	SRC_RSRC COMMENT 'Source Resource (Means of Transport or User) - Technical name: SRSRC - Component Type: /SCWM/DE_SRSRC',
	DEST_STRG_BIN COMMENT 'Destination Storage Bin - Technical name: NLPLA - Component Type: /SCWM/LTAP_NLPLA',
	DEST_HU COMMENT 'Destination Handling Unit - Technical name: NLENR - Component Type: /SCWM/LTAP_NLENR',
	OWNER COMMENT 'Owner - Technical name: OWNER - Component Type: /SCWM/DE_OWNER',
	DEST_STRG_TYPE COMMENT 'Destination Storage Type - Technical name: NLTYP - Component Type: /SCWM/LTAP_NLTYP',
	DEST_RSRC COMMENT 'Destination Resource (Means of Transport or User) - Technical name: DRSRC - Component Type: /SCWM/DE_DRSRC',
	GR_DT COMMENT 'Goods Receipt Date - Technical name: GRDATE - Component Type: /SCWM/DE_GR_DATE',
	GR_PROC_TM COMMENT 'Goods Receipt Processing Time - Technical name: GRTIME - Component Type: /SCWM/DE_GR_TIME',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	RECEIPT_FG COMMENT 'Receipt flag for counted pallets',
	PUTAWAY_FG COMMENT 'Putaway flag for picked up palltes'
) AS
WITH
-- Received deliveries
whtrec AS (
	SELECT
		client_id
		,lidl_country AS lidl_ctry
		,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
		,wh_task_nr
		,wh_task_item
		,wh_task_stat
		,wh_process_type AS wh_proc_type
		,wh_process_cat AS wh_proc_cat
		,doc_nr
		,doc_cat
		,product_nr AS prod_nr
		,prod_desc
		,confirmed_dt AS conf_dt
		,confirmed_tm AS conf_tm
		,TIMESTAMPFROMPARTS(conf_dt, conf_tm) AS conf_ts
		,DATE_TRUNC(HOUR, conf_tm) AS conf_hr
		,hu_flg AS hu_fg
		,src_strg_bin
		,src_hu
		,src_strg_type
		,src_rsrc
		,dest_strg_bin
		,dest_hu
		,IFF(client_id = 10 AND wh_id = 7, owner_id, 'Not Applicable') AS OWNER
		,dest_strg_type
		,dest_rsrc
		,goods_recpt_dt AS gr_dt
		,goods_recpt_procs_tm AS gr_proc_tm
		,dwh_created
		,dwh_updated
	FROM "DATA".T_LOGOP_SAPEWM_WAREHOUSETASK 
	WHERE wh_proc_cat = 5 -- Goods Receipt Posting
		AND wh_task_stat = 'C' -- null = Open, 'A' = Canceled , 'B' = Waiting , 'C' = Confirmed
		AND doc_nr IS NOT NULL
		AND dest_hu IS NOT NULL
),
-- Reversed deliveries
whtrev AS (
	SELECT
		client_id
		,lidl_country AS lidl_ctry
		,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
		,wh_task_stat
		,wh_process_cat AS wh_proc_cat
		,doc_cat
		,doc_nr
		,confirmed_dt AS conf_dt
		,src_hu
		,confirmed_tm AS conf_tm
	FROM "DATA".T_LOGOP_SAPEWM_WAREHOUSETASK 
	WHERE wh_proc_cat = 6 -- Goods Issue Posting
		AND wh_task_stat = 'C' -- confirmed
		AND doc_cat = 'PDI'
		AND doc_nr IS NOT NULL
		AND src_hu IS NOT NULL
),
-- receipts with latest timestamp per day and handling unit
receipts AS (
	SELECT
		r.client_id
		,r.lidl_ctry
		,r.wh_id
		,r.wh_task_nr
		,r.wh_task_item
		,r.wh_task_stat
		,r.wh_proc_type
		,r.wh_proc_cat
		,r.doc_nr
		,r.doc_cat
		,r.prod_nr
		,r.prod_desc
		,r.conf_dt
		,r.conf_tm
		,r.conf_ts
		,r.conf_hr
		,r.hu_fg
		,r.src_strg_bin
		,r.src_hu
		,r.src_strg_type
		,r.src_rsrc
		,r.dest_strg_bin
		,r.dest_hu
		,r.OWNER
		,r.dest_strg_type
		,r.dest_rsrc
		,r.gr_dt
		,r.gr_proc_tm
		,r.dwh_created
		,r.dwh_updated
	FROM whtrec r
	    LEFT JOIN whtrev rev
			ON r.client_id = rev.client_id
				AND r.wh_id = rev.wh_id
				AND r.dest_hu = rev.src_hu
				AND r.conf_dt <= rev.conf_dt
				AND r.conf_tm <= rev.conf_tm
	WHERE rev.conf_dt IS NULL -- not reversed
	AND r.dest_strg_type <> '9996'
	QUALIFY ROW_NUMBER() OVER (PARTITION BY r.client_id, r.wh_id, r.conf_dt, r.dest_hu ORDER BY r.conf_tm DESC) = 1 -- most recent record per handling unit
),
-- putaways with the earliest timestamp per day and handling unit
putaways AS (
	SELECT
		client_id
		,lidl_country AS lidl_ctry
		,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
		,wh_task_nr
		,wh_task_item
		,wh_task_stat
		,wh_process_type AS wh_proc_type
		,wh_process_cat AS wh_proc_cat
		,doc_nr
		,doc_cat
		,product_nr AS prod_nr
		,prod_desc
		,confirmed_dt AS conf_dt
		,confirmed_tm AS conf_tm
		,TIMESTAMPFROMPARTS(conf_dt, conf_tm) AS conf_ts
		,DATE_TRUNC(HOUR, conf_tm) AS conf_hr
		,hu_flg AS hu_fg
		,src_strg_bin
		,src_hu
		,src_strg_type
		,src_rsrc
		,dest_strg_bin
		,dest_hu
		,IFF(client_id = 10 AND wh_id = 7, owner_id, 'Not Applicable') AS OWNER
		,dest_strg_type
		,dest_rsrc
		,goods_recpt_dt AS gr_dt
		,goods_recpt_procs_tm AS gr_proc_tm
		,dwh_created
		,dwh_updated
	FROM "DATA".T_LOGOP_SAPEWM_WAREHOUSETASK 
	WHERE wh_task_stat = 'C' -- C = confirmed
		AND ((wh_proc_cat = 1) OR (wh_proc_cat = 3 AND wh_proc_type IN ('3050', '9999'))) -- WH process category 1 = putaway 
		AND NVL(doc_cat, '') <> 'PDO'
		AND LEFT(src_strg_type, 1) IN ('9', 'D', 'W')
		AND LEFT(NVL(dest_strg_type, ''), 1) <> 'W'
		AND dest_hu IS NOT NULL
	QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id, wh_id, conf_dt, src_hu ORDER BY conf_tm DESC) = 1 --oldest putaway task that occurs immediately after the goods receiving
)
-- consolidation of receipts and putaways
SELECT
	r.client_id
	,r.lidl_ctry
	,r.wh_id
	,r.wh_task_nr
	,r.wh_task_item
	,r.wh_task_stat
	,r.wh_proc_type
	,r.wh_proc_cat
	,r.doc_nr
	,r.doc_cat
	,r.prod_nr
	,r.prod_desc
	,r.conf_dt
	,r.conf_tm
	,r.conf_ts
	,r.conf_hr
	,r.hu_fg
	,r.src_strg_bin
	,r.src_hu
	,r.src_strg_type
	,r.src_rsrc
	,r.dest_strg_bin
	,r.dest_hu
	,r.OWNER
	,r.dest_strg_type
	,r.dest_rsrc
	,r.gr_dt
	,r.gr_proc_tm
	,r.dwh_created
	,r.dwh_updated
	,1 AS receipt_fg
	,0 AS putaway_fg
FROM receipts r
UNION ALL -- consolidation of data for aggregation on hour LEVEL in FE
SELECT
	p.client_id
	,p.lidl_ctry
	,p.wh_id
	,p.wh_task_nr
	,p.wh_task_item
	,p.wh_task_stat
	,p.wh_proc_type
	,p.wh_proc_cat
	,p.doc_nr
	,p.doc_cat
	,p.prod_nr
	,p.prod_desc
	,p.conf_dt
	,p.conf_tm
	,p.conf_ts
	,p.conf_hr
	,p.hu_fg
	,p.src_strg_bin
	,p.src_hu
	,p.src_strg_type
	,p.src_rsrc
	,p.dest_strg_bin
	,p.dest_hu
	,p.OWNER
	,r.dest_strg_type -- Original destination storage type from received pallets
	,p.dest_rsrc
	,p.gr_dt
	,p.gr_proc_tm
	,p.dwh_created
	,p.dwh_updated
	,0 AS receipt_fg
	,1 AS putaway_fg
FROM receipts r
	 JOIN putaways p 
		ON r.client_id = p.client_id
			AND r.wh_id = p.wh_id
			AND r.dest_hu = p.src_hu
			-- the product match is to avoid a mismatch because there can be same hus but with different products at an earlier point of time (pallet numbers / labels are printed and used twice)  
			-- nvl is to avoid a missing match because some prod nrs from receipts can be empty which have a prod nr DSP* in the putaway  
			AND NVL(r.prod_nr, p.prod_nr) = NVL(p.prod_nr, r.prod_nr)
			AND r.gr_dt = p.gr_dt
			AND r.conf_ts <= p.conf_ts -- putaways can and must happen anytime after the receipt 
			--AND r.conf_dt = p.conf_dt
			--AND r.conf_tm <= p.conf_tm --conf_ts not needed because conf_dt already is equal
QUALIFY ROW_NUMBER() OVER (PARTITION BY p.client_id, p.wh_id, p.src_hu, p.prod_nr, p.gr_dt ORDER BY p.conf_dt, p.conf_tm) = 1;