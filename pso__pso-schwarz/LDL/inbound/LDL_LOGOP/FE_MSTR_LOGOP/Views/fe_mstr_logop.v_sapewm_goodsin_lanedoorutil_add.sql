/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_goodsin_lanedoorutil_add
Description		|	SAP EWM Goods In - view with additional columns 
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_goodsin_lanedoorutil_add (
	CLIENT_ID COMMENT 'Client id (PK)',
	LIDL_CTRY COMMENT 'Country code',
	WH_ID COMMENT 'Warehouse ID (PK)',
	WH_TASK_NR COMMENT 'Warehouse Task (PK)',
	WH_TASK_ITEM COMMENT 'Warehouse Task Item (PK)',
	CONF_DT COMMENT 'Confirmation date',
	CONF_TM COMMENT 'Confirmation time',
	WH_PROC_CAT COMMENT 'Warehouse Process Category',
	WH_TASK_STAT COMMENT 'Warehouse Task Status',
	PROD_NR COMMENT 'Product number',
	PROD_DESC COMMENT 'Product description',
	DOC_NR COMMENT 'Document number (PK)',
	DOC_CAT COMMENT 'Document Category for Document-Related Stocks',
	DEST_HU COMMENT 'Destination handling unit',
	DEST_STRG_BIN COMMENT 'Destination storage bin',
	DEST_STRG_TYPE COMMENT 'Destination storage type',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	REV_CONF_DT COMMENT 'Confirmation date of reversal',
	REV_CONF_TM COMMENT 'Confirmation time of reversal',
	REV_DOC_NR COMMENT 'Document number of reversal',
	REV_SRC_HU COMMENT 'Source Handling Unit of reversal',
	WH_DOOR_NR COMMENT 'Warehouse door number',
	PLND_DLV_DT COMMENT 'Planned delivery date'
) COMMENT='SAP EWM Goods In - view with additional columns (PK client_id, wh_id, wh_task_nr, wh_task_item, doc_nr)'
 AS
WITH
-- Received deliveries
whtrec AS (
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
		,dwh_created
		,dwh_updated
	FROM "DATA".t_logop_sapewm_warehousetask -- Primary key (client_id, wh_id, wh_task_nr, wh_task_item)
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
		,dwh_created
		,dwh_updated
	FROM "DATA".t_logop_sapewm_warehousetask
	WHERE wh_proc_cat = 6 -- Goods Issue Posting
		AND doc_nr IS NOT NULL
		AND src_hu IS NOT NULL
		AND doc_cat = 'PDI'
		AND wh_task_stat = 'C' -- confirmed
),
inbdlvhdr AS (
	SELECT
		client_id
		,lidl_country AS lidl_ctry
		,source_system AS src_sys
		,wh_nr
		,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
		,doc_nr
		,ship_from_nr
		,vehicle_nr
		,transport_unit
		,adv_ship_notif
		,lia_nr
		,wh_door_nr
		,item_cnt
		,product_cnt AS prod_cnt
		,planned_dlv_dt AS plnd_dlv_dt
		,planned_dlv_tm AS plnd_dlv_tm
		,crtd_on_dt
		,crtd_at_tm
		,purchase_order_nr AS pur_ord_nr
		,dwh_load_id
		,dwh_created
		,dwh_updated
	FROM DATA.t_logop_sapewm_inbdlvhdr
)
SELECT
	rc.client_id
	,rc.lidl_ctry
	,rc.wh_id
	,rc.wh_task_nr
	,rc.wh_task_item
	,rc.conf_dt
	,rc.conf_tm
	,rc.wh_proc_cat
	,rc.wh_task_stat
	,rc.prod_nr
	,rc.prod_desc
	,rc.doc_nr
	,rc.doc_cat
	--,rc.src_hu
	--,rc.src_strg_bin
	--,rc.src_strg_type
	,rc.dest_hu
	,rc.dest_strg_bin
	,rc.dest_strg_type
	,rc.dwh_created
	,rc.dwh_updated
	,rv.conf_dt AS rev_conf_dt
	,rv.conf_tm AS rev_conf_tm
	,rv.doc_nr AS rev_doc_nr
	,rv.src_hu AS rev_src_hu
	,NVL(i.wh_door_nr, 'Unassigned') -- To cover the cases where HUs have no warehouse door assigned  
	,i.plnd_dlv_dt
FROM whtrec rc
	LEFT JOIN whtrev rv
		ON rc.client_id = rv.client_id
			AND rc.wh_id = rv.wh_id
			AND rc.dest_hu = rv.src_hu
			AND rc.conf_dt <= rv.conf_dt
			AND rc.doc_nr = rv.doc_nr -- Multiple receptions of one pallet AND AT least one reversal
	LEFT JOIN inbdlvhdr i -- Primary key (client_id, wh_id, doc_nr)
		ON rc.client_id = i.client_id
			AND rc.wh_id = i.wh_id
			AND rc.doc_nr = i.doc_nr
			--AND rc.conf_dt= i.crtd_on_dt -- Ignore create date because with this filter HUs would not get wh doors assigned though the documents are existing in inbdlvhdr. Doc nr is a PK and unique anyway. 
WHERE rv.conf_dt IS NULL
	AND rc.dest_strg_type <> '9996';