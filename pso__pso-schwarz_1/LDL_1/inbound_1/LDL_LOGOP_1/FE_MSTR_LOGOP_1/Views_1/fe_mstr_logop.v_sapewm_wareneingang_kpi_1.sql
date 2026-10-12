CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_WARENEINGANG_KPI_1(
	CLIENT_ID COMMENT 'Client id (PK)',
	LIDL_CTRY COMMENT 'Country_1 code',
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
	SRC_HU COMMENT 'Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	SRC_STRG_TYPE COMMENT 'Source Storage Type - Technical name: VLTYP - Component Type: /SCWM/LTAP_VLTYP',
	DEST_HU COMMENT 'Destination Handling Unit_1 - Technical name: NLENR - Component Type: /SCWM/LTAP_NLENR',
	DEST_STRG_TYPE COMMENT 'Destination Storage Type - Technical name: NLTYP - Component Type: /SCWM/LTAP_NLTYP',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	ACT_QTY_DEST_BUOM COMMENT 'Destination Actual Quantity in Stockkeeping Unit_1 - Technical name: NISTM - Component Type: /SCWM/DE_UI_NISTM',
	AUOM COMMENT 'Alternative Unit_1 of Measure for Stockkeeping Unit_1 - Technical name: ALTME - Component Type: /SCWM/DE_AUNIT',
	ACT_DEST_QNTY_AUOM COMMENT 'Actual Destination Quantity in Alternative Unit_1 - Technical name: NISTA - Component Type: /SCWM/DE_UI_NISTA',
	RECEIPT_FG COMMENT 'Receipt flag for counted pallets'
) AS
SELECT
		 client_id
		,lidl_ctry
		,wh_id
		,wh_task_nr
		,wh_proc_cat
		,doc_nr
		,doc_cat
		,prod_nr
		,prod_desc
		,conf_dt
		,conf_tm
		,conf_ts
		,conf_hr
		,confirmed_by
		,src_hu
		,src_strg_type
		,dest_hu
		,dest_strg_type
		,dwh_created
		,dwh_updated
		,act_qty_dest_buom 
		,auom 
		,act_dest_qnty_auom
		,receipt_fg
FROM FE_MSTR_LOGOP.V_SAPEWM_WARENEINGANG_ADD_1
;