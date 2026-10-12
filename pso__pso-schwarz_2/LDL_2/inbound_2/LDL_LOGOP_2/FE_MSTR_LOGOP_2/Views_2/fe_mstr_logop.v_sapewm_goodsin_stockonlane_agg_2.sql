/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_goodsin_stockonlane_agg_2
Description		|	SAP EWM Goods In - view with aggregations
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_GOODSIN_STOCKONLANE_AGG_2(
	CLIENT_ID COMMENT 'Client id (PK)',
	LIDL_CTRY COMMENT 'Country_2 code',
	WH_ID COMMENT 'Warehouse ID (PK)',
	WH_TASK_NR COMMENT 'Warehouse Task (PK)',
	WH_TASK_ITEM COMMENT 'Warehouse Task Item_2 (PK)',
	WH_TASK_STAT COMMENT 'Warehouse Task Status_2 - Technical name: TOSTAT - Component Type: /SCWM/DE_TOSTAT',
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
	HU_FG COMMENT 'Handling Unit_2 Warehouse Task - Technical name: FLGHUTO - Component Type: /SCWM/FLGHUTO',
	SRC_STRG_BIN COMMENT 'Source Storage Bin - Technical name: VLPLA - Component Type: /SCWM/LTAP_VLPLA',
	SRC_HU COMMENT 'Source Handling Unit_2 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	SRC_STRG_TYPE COMMENT 'Source Storage Type - Technical name: VLTYP - Component Type: /SCWM/LTAP_VLTYP',
	SRC_RSRC COMMENT 'Source Resource (Means of Transport or User) - Technical name: SRSRC - Component Type: /SCWM/DE_SRSRC',
	DEST_STRG_BIN COMMENT 'Destination Storage Bin - Technical name: NLPLA - Component Type: /SCWM/LTAP_NLPLA',
	DEST_HU COMMENT 'Destination Handling Unit_2 - Technical name: NLENR - Component Type: /SCWM/LTAP_NLENR',
	OWNER COMMENT 'Owner - Technical name: OWNER - Component Type: /SCWM/DE_OWNER',
	DEST_STRG_TYPE COMMENT 'Destination Storage Type - Technical name: NLTYP - Component Type: /SCWM/LTAP_NLTYP',
	DEST_RSRC COMMENT 'Destination Resource (Means of Transport or User) - Technical name: DRSRC - Component Type: /SCWM/DE_DRSRC',
	GR_DT COMMENT 'Goods Receipt Date - Technical name: GRDATE - Component Type: /SCWM/DE_GR_DATE',
	GR_PROC_TM COMMENT 'Goods Receipt Processing Time - Technical name: GRTIME - Component Type: /SCWM/DE_GR_TIME',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	RECEIPT_FG COMMENT 'Receipt flag for counted pallets',
	PUTAWAY_FG COMMENT 'Putaway flag for picked up palltes',
	TM_ON_LANE_SEC COMMENT 'Time of pallets on lane between receipt and putaway in seconds for average and median time',
	CUM_PALLETS_COUNTED COMMENT 'Amount of pallets in receipts cumulated per group of client, warehouse, day, hour and destination storage type',
	CUM_PALLETS_PICKEDUP COMMENT 'Amount of pallets in putaways cumulated per group of client, warehouse, day, hour and destination storage type',
	CUM_PALLETS_ON_LANE COMMENT 'Amount of pallets on lane cumulated per group of client, warehouse, day, hour and destination storage type'
) AS
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
	,prod_nr
	,prod_desc
	,conf_dt
	,conf_tm
	,conf_ts
	,conf_hr
	,hu_fg
	,src_strg_bin
	,src_hu
	,src_strg_type
	,src_rsrc
	,dest_strg_bin
	,dest_hu
	,OWNER
	,dest_strg_type
	,dest_rsrc
	,gr_dt
	,gr_proc_tm
	,dwh_created
	,dwh_updated
	,receipt_fg
	,putaway_fg
	,IFF (putaway_fg = 1
		,TIMEDIFF (SECOND
			,FIRST_VALUE(conf_tm) OVER (PARTITION BY client_id, wh_id, conf_dt, dest_hu ORDER BY conf_tm)
			,LAST_VALUE(conf_tm) OVER (PARTITION BY client_id, wh_id, conf_dt, dest_hu ORDER BY conf_tm)
			)
		,NULL) AS tm_on_lane_sec -- duration of pallets on lane in seconds
	,IFF (RANK() OVER (PARTITION BY client_id, wh_id, conf_dt, conf_hr, dest_strg_type ORDER BY conf_tm DESC, gr_proc_tm DESC, wh_task_nr) = 1
		,SUM(receipt_fg) OVER (PARTITION BY client_id, wh_id, conf_dt, dest_strg_type ORDER BY conf_tm ASC ROWS UNBOUNDED PRECEDING) 
		,NULL
		) AS cum_pallets_counted -- amount of pallets cumulated per client, warehouse, day, hour and destination storage type for receipts
	,IFF (RANK() OVER (PARTITION BY client_id, wh_id, conf_dt, conf_hr, dest_strg_type ORDER BY conf_tm DESC, gr_proc_tm DESC, wh_task_nr) = 1
		,SUM(putaway_fg) OVER (PARTITION BY client_id, wh_id, conf_dt, dest_strg_type ORDER BY conf_tm, gr_proc_tm ROWS UNBOUNDED PRECEDING) 
		,NULL
		) AS cum_pallets_pickedup -- amount of pallets cumulated per client, warehouse, day, hour and destination storage type for putaways
	,cum_pallets_counted - cum_pallets_pickedup AS cum_pallets_on_lane
FROM fe_mstr_logop.v_sapewm_goodsin_stockonlane_add_2;