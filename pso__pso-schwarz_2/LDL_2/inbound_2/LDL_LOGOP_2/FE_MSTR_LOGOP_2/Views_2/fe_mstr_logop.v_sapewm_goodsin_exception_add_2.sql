/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_goodsin_exception_add_2
Description		|	SAP EWM Goods In - view with additional columns 
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_goodsin_exception_add_2 (
	CLIENT_ID COMMENT 'Client ID (PK)',
	LIDL_CTRY COMMENT 'Country_2 code',
	WH_ID COMMENT 'Warehouse ID (PK)',
	WH_TASK_NR COMMENT 'Warehouse task number (PK)',
	WH_TASK_ITEM COMMENT 'Warehouse Task Item_2 (PK)',
	CONF_DT COMMENT 'Confirmation date',
	CONF_TM COMMENT 'Confirmation time',
	WH_PROC_CAT COMMENT 'Warehouse process category',
	WH_TASK_STAT COMMENT 'Warehouse Task Status_2',
	PROD_NR COMMENT 'Product number',
	PROD_DESC COMMENT 'Product short description',
	DOC_NR COMMENT 'Document number',
	DOC_CAT COMMENT 'Document category for document-related stocks',
	SRC_HU COMMENT 'Source handling unit_2',
	SRC_STRG_BIN COMMENT 'Source storage bin',
	SRC_STRG_TYPE COMMENT 'Source storage type',
	DEST_HU COMMENT 'Destination handling unit_2',
	DEST_STRG_BIN COMMENT 'Destination storage bin',
	DEST_STRG_TYPE COMMENT 'Destination storage type',
	QUEUE COMMENT 'Queue',
	ACT_AREA COMMENT 'Activity area',
	ACT_TYPE COMMENT 'Activity type',
	EXC_CD COMMENT 'Exception code',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	RECEIPT_FG COMMENT 'Flag for original receipt record',
	DEST_STRG_BIN_CLRG COMMENT 'Destination storage bin of clearing',
	CLRG_AREA COMMENT 'Area of clearing',
	REJECTED_AREA COMMENT 'Area of rejection',
	CLEARING_CNT COMMENT 'Clearing count',
	REVERSAL_CNT COMMENT 'Reversal count',
	UNDERDELIV_CNT COMMENT 'Underdelivery if delivered quantity is smaller than ordered quantity',
	CLEARING_AMOUNT COMMENT 'Amount of clearing without underdelivery'
) COMMENT='SAP EWM Goods In - view with additional columns (PK client_id, wh_id, wh_task_nr, wh_task_item)'
 AS
WITH
-- goods in receipts
receipts AS (
	SELECT 
		client_id
		,lidl_country AS lidl_ctry
		,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
		,wh_task_nr
		,wh_task_item
		,confirmed_dt AS conf_dt
		,confirmed_tm AS conf_tm
		,wh_process_cat AS wh_proc_cat
		,wh_task_stat
		,product_nr AS prod_nr
		,prod_desc
		,doc_nr
		,doc_cat
		,src_hu
		,src_strg_bin
		,src_strg_type
		,dest_hu
		,dest_strg_bin
		,dest_strg_type
		,QUEUE
		,activity_area AS act_area
		,activity_type AS act_type
		,exception_cd AS exc_cd
		,dwh_created
		,dwh_updated
	FROM "DATA".t_logop_sapewm_warehousetask_2 -- Primary key (client_id, wh_id, wh_task_nr, wh_task_item)
	WHERE wh_task_stat = 'C' -- NULL = Open, 'A' = Canceled , 'B' = Waiting , 'C' = Confirmed
		AND wh_proc_cat = 5
		AND dest_hu IS NOT NULL
		AND doc_nr IS NOT NULL
	),
-- goods in the clearing area
clearings AS (
	SELECT
		client_id
		--,lidl_ctry
		,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
		--,wh_task_nr
		--,wh_task_item
		,confirmed_dt AS conf_dt
		,confirmed_tm AS conf_tm
		--,wh_proc_cat
		--,wh_task_stat
		--,prod_nr
		--,prod_desc
		--,doc_nr
		--,doc_cat
		,src_hu
		--,src_strg_bin
		--,src_strg_type
		--,dest_hu
		,dest_strg_bin
		--,dest_strg_type
		--,QUEUE
		,activity_area AS act_area
		--,act_type
		--,exc_cd
		--,dwh_created
		--,dwh_updated
		,CASE
			WHEN (act_area = 'WCL1' OR CONTAINS(dest_strg_bin, '9100')) THEN 'Ambient'
			WHEN (act_area = 'WCL4' OR CONTAINS(dest_strg_bin, '9400')) THEN 'Fruit & Veg.'
			WHEN (act_area = 'WCL5' OR CONTAINS(dest_strg_bin, '9500')) THEN 'Chiller'
			WHEN (act_area = 'WCL7' OR CONTAINS(dest_strg_bin, '9700')) THEN 'TIKO'
			WHEN CONTAINS(dest_strg_bin, '9800') THEN 'AHR'
			ELSE 'Unassigned'
			END AS clrg_area
		--,RIGHT(dest_strg_bin, 4) AS class_area -- brauchen wir gar nicht im FE
		,COUNT(wh_task_nr) AS clearing_cnt 
	FROM "DATA".t_logop_sapewm_warehousetask_2 
	WHERE wh_task_stat IN ('A', 'C') -- NULL = Open, 'A' = Canceled , 'B' = Waiting , 'C' = Confirmed
		AND (STARTSWITH(dest_strg_type, 'W') OR dest_strg_bin = '9800') -- specifies clearing area with destination bin beginning with WPCO / WCL (before or after counting) because consultation with goods in control is necessary. 9800 extension requested to cover AHR.
		AND (QUEUE IN ('INB_AHR', 'INB_AMB', 'INB_CHL', 'INB_FRZ', 'INB_F+V', 'INB1_AMB', 'INB1_CHL', 'INB1_FRZ', 'INB1_F+V', 'INB3_F+V')
				AND act_area = 'WPCO'
			OR QUEUE IS NULL
				AND act_area IN ('WCL1', 'WCL4', 'WCL5', 'WCL7')
			)
	GROUP BY client_id, wh_id, src_hu, conf_dt, conf_tm, dest_strg_bin, act_area -- dest_strg_bin and act_area are not needed for the final join 
	--QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id, wh_id, src_hu, conf_dt, dest_strg_bin, act_area ORDER BY conf_tm) = 1 
	),
-- goods that have been reversed
reversals AS (
	SELECT
		client_id
		--,lidl_ctry
		,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
		--,wh_task_nr
		--,wh_task_item
		,confirmed_dt AS conf_dt
		,confirmed_tm AS conf_tm
		--,wh_proc_cat
		--,wh_task_stat
		--,prod_nr
		--,prod_desc
		--,doc_nr
		--,doc_cat
		,src_hu
		--,src_strg_bin
		--,src_strg_type
		--,dest_hu
		--,dest_strg_bin
		--,dest_strg_type
		--,QUEUE
		--,act_area
		--,act_type
		--,exc_cd
		--,dwh_created
		--,dwh_updated
		,COUNT(wh_task_nr) AS reversal_cnt
		,COUNT_IF(exception_cd = 'Z009') AS underdeliv_cnt
		,CASE
			WHEN (activity_area = 'WCL1' OR CONTAINS(src_strg_bin, '9100')) THEN 'Ambient'
			WHEN (activity_area = 'WCL4' OR CONTAINS(src_strg_bin, '9400')) THEN 'Fruit & Veg.'
			WHEN (activity_area = 'WCL5' OR CONTAINS(src_strg_bin, '9500')) THEN 'Chiller'
			WHEN (activity_area = 'WCL7' OR CONTAINS(src_strg_bin, '9700')) THEN 'TIKO'
			WHEN CONTAINS(src_strg_bin, '9800') THEN 'AHR'
			ELSE 'Unassigned'
			END AS rejected_area
	FROM "DATA".t_logop_sapewm_warehousetask_2 
	WHERE wh_process_cat = 6 -- reversed deliveries
		AND doc_nr IS NOT NULL
		AND src_hu IS NOT NULL
		AND doc_cat = 'PDI'
		AND wh_task_stat = 'C' -- confirmed
	GROUP BY client_id, wh_id, src_hu, conf_dt, conf_tm, activity_area, src_strg_bin
	--QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id, wh_id, src_hu ORDER BY conf_dt, conf_tm) = 1
	)
SELECT
	r.client_id
	,r.lidl_ctry
	,r.wh_id
	,r.wh_task_nr
	,r.wh_task_item
	,r.conf_dt
	,r.conf_tm
	,r.wh_proc_cat
	,r.wh_task_stat
	,r.prod_nr
	,r.prod_desc
	,r.doc_nr
	,r.doc_cat
	,r.src_hu
	,r.src_strg_bin
	,r.src_strg_type
	,r.dest_hu
	,r.dest_strg_bin
	,r.dest_strg_type
	,r.QUEUE
	,r.act_area
	,r.act_type
	,r.exc_cd
	,r.dwh_created
	,r.dwh_updated
	,IFF(ROW_NUMBER() OVER (PARTITION BY r.client_id, r.wh_id, r.wh_task_nr, r.wh_task_item ORDER BY c.conf_dt, c.conf_tm) = 1, 1, 0) AS receipt_fg -- flag for receipt records without records from clearings or reversals 
	,c.dest_strg_bin AS dest_strg_bin_clrg
	--,c.act_area -- brauchen wir gar nicht im FE
	,c.clrg_area
	,rv.rejected_area
	--,c.class_area -- classification of assortment area -- brauchen wir gar nicht im FE
	,NVL(c.clearing_cnt, 0) AS clearing_cnt
	,IFF(NVL(rv.reversal_cnt, 0) AND receipt_fg = 1, 1, 0) AS reversal_cnt
	,NVL(rv.underdeliv_cnt, 0) AS underdeliv_cnt -- underdelivery if delivered quantity is smaller than ordered quantity
	,IFF(c.clearing_cnt > 0 AND receipt_fg = 1,  clearing_cnt - NVL(rv.underdeliv_cnt, 0), 0) AS clearing_amount -- number of clearings without underdelivery. Flag extension covering special cases discovered during UAT
FROM receipts r 
	LEFT JOIN clearings c
		ON r.client_id = c.client_id 
			AND r.wh_id = c.wh_id 
			AND r.dest_hu = c.src_hu
			AND r.conf_dt = c.conf_dt -- to ensure that clearings of a HU before and after the receipt are ignored
			AND r.conf_tm <= c.conf_tm -- This filter excludes the clearings that happen before the receipt which is actually not possible 
	LEFT JOIN reversals rv
		ON r.client_id = rv.client_id 
			AND r.wh_id = rv.wh_id 
			AND r.dest_hu = rv.src_hu
			AND r.conf_dt = rv.conf_dt
			AND r.conf_tm <= rv.conf_tm; -- To avoid that HUs that are counted twice (two confirmed receipts) are also reversed twices (HU received, reversed and received again)