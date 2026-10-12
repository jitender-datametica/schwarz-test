CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_WARENEINGANG_ADD(
	CLIENT_ID COMMENT 'Client id (PK)',
	LIDL_CTRY COMMENT 'Country code',
	WH_ID COMMENT 'Warehouse ID (PK)',
	WH_TASK_NR COMMENT 'Warehouse Task (PK)',
	WH_PROC_CAT COMMENT 'Warehouse Process Category - Technical name: TRART - Component Type: /SCWM/LVS_TRART',
	DOC_NR COMMENT 'Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT',
	DOC_CAT COMMENT 'Document Category for Document-Related Stocks - Technical name: QDOCCAT - Component Type: /SCWM/DE_UI_QDOCCAT',
	PROD_NR COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR',
	PROD_DESC COMMENT 'Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX',
	CONF_DT COMMENT 'Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE',
	CONF_TM COMMENT 'Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME',
	CONF_TS COMMENT 'Confirmation timestamp',
	CONF_HR COMMENT 'Confirmation hour',
	CONFIRMED_BY COMMENT 'Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY',
	SRC_HU COMMENT 'Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	SRC_STRG_TYPE COMMENT 'Source Storage Type - Technical name: VLTYP - Component Type: /SCWM/LTAP_VLTYP',
	DEST_HU COMMENT 'Destination Handling Unit - Technical name: NLENR - Component Type: /SCWM/LTAP_NLENR',
	DEST_STRG_TYPE COMMENT 'Destination Storage Type - Technical name: NLTYP - Component Type: /SCWM/LTAP_NLTYP',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	ACT_QTY_DEST_BUOM COMMENT 'Destination Actual Quantity in Stockkeeping Unit - Technical name: NISTM - Component Type: /SCWM/DE_UI_NISTM',
	AUOM COMMENT 'Alternative Unit of Measure for Stockkeeping Unit - Technical name: ALTME - Component Type: /SCWM/DE_AUNIT',
	ACT_DEST_QNTY_AUOM COMMENT 'Actual Destination Quantity in Alternative Unit - Technical name: NISTA - Component Type: /SCWM/DE_UI_NISTA',
	RECEIPT_FG COMMENT 'Receipt flag for counted pallets'
) AS
WITH
-- Received deliveries (Angenommen)
whtrec AS (
	SELECT
		client_id
		,lidl_country AS lidl_ctry
		,wh_id
		,tanum AS wh_task_nr
		,trart AS wh_proc_cat
		,docno AS doc_nr
		,doccat AS doc_cat
		,matnr AS prod_nr
		,maktx AS prod_desc
		,confirmed_date AS conf_dt
		,confirmed_time AS conf_tm
		,TIMESTAMP_FROM_PARTS(conf_dt, conf_tm) AS conf_ts
		,DATE_TRUNC(HOUR, conf_tm) AS conf_hr
		,confirmed_by
		,vlenr AS src_hu
		,vltyp AS src_strg_type
		,nlenr AS dest_hu
		,nltyp AS dest_strg_type
		,dwh_created
		,dwh_updated
		,nistm AS act_qty_dest_buom 
		,altme AS auom 
		,nista AS act_dest_qnty_auom
	FROM "DATA".T_SAPEWM_WAREHOUSETASK 
	WHERE wh_proc_cat = 5 -- Goods Receipt Posting
		AND tostat = 'C' -- null = Open, 'A' = Canceled , 'B' = Waiting , 'C' = Confirmed
		AND doc_nr IS NOT NULL
		AND dest_hu IS NOT NULL
		AND dest_strg_type <> '9996'
),
-- Reversed deliveries (Reversed)
whtrev AS (
	SELECT
		client_id
		,lidl_country AS lidl_ctry
		,wh_id
		,tanum AS wh_task_nr
		,trart AS wh_proc_cat
		,docno AS doc_nr
		,doccat AS doc_cat
		,matnr AS prod_nr
		,maktx AS prod_desc
		,confirmed_date AS conf_dt
		,confirmed_time AS conf_tm
		,TIMESTAMP_FROM_PARTS(conf_dt, conf_tm) AS conf_ts
		,DATE_TRUNC(HOUR, conf_tm) AS conf_hr
		,confirmed_by
		,vlenr AS src_hu
		,vltyp AS src_strg_type
		,nlenr AS dest_hu
		,nltyp AS dest_strg_type
		,dwh_created
		,dwh_updated
		,nistm AS act_qty_dest_buom 
		,altme AS auom 
		,nista AS act_dest_qnty_auom
	FROM "DATA".T_SAPEWM_WAREHOUSETASK 
	WHERE wh_proc_cat = 6 -- Goods Issue Posting
		AND tostat = 'C' -- confirmed
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
		,r.wh_proc_cat
		,r.doc_nr
		,r.doc_cat
		,r.prod_nr
		,r.prod_desc
		,r.conf_dt
		,r.conf_tm
		,r.conf_ts
		,r.conf_hr
		,r.confirmed_by
		,r.src_hu
		,r.src_strg_type
		,r.dest_hu
		,r.dest_strg_type
		,r.dwh_created
		,r.dwh_updated
		,r.act_qty_dest_buom 
		,r.auom 
		,r.act_dest_qnty_auom
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
)
SELECT
		rc.client_id
		,rc.lidl_ctry
		,rc.wh_id
		,rc.wh_task_nr
		,rc.wh_proc_cat
		,rc.doc_nr
		,rc.doc_cat
		,rc.prod_nr
		,rc.prod_desc
		,rc.conf_dt
		,rc.conf_tm
		,rc.conf_ts
		,rc.conf_hr
		,rc.confirmed_by
		,rc.src_hu
		,rc.src_strg_type
		,rc.dest_hu
		,rc.dest_strg_type
		,rc.dwh_created
		,rc.dwh_updated
		,rc.act_qty_dest_buom 
		,rc.auom 
		,rc.act_dest_qnty_auom
		,1 AS receipt_fg
FROM receipts rc
;