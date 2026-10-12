/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_gpl_performance_putaway_add
Description		|	SAP EWM Gruppenleiter Dahsboard Putaway - KPI View
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_gpl_performance_putaway_kpI(
	client_id COMMENT 'Client id (PK)',
	lidl_ctry COMMENT 'Country code (PK)',
	wh_id COMMENT 'Warehouse ID',
	wh_task_nr COMMENT 'Warehouse Task (PK)',
	wh_task_item COMMENT 'Warehouse Task Item (PK)',
	wh_task_stat COMMENT 'Warehouse Task Status - Technical name: TOSTAT - Component Type: /SCWM/DE_TOSTAT',
	wh_proc_type COMMENT 'Warehouse Process Type - Technical name: PROCTY - Component Type: /SCWM/DE_PROCTY',
	wh_proc_cat COMMENT 'Warehouse Process Category - Technical name: TRART - Component Type: /SCWM/LVS_TRART',
	doc_nr COMMENT 'Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT',
	doc_cat COMMENT 'Document Category for Document-Related Stocks - Technical name: QDOCCAT - Component Type: /SCWM/DE_UI_QDOCCAT',
	prod_nr COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR',
	prod_desc COMMENT 'Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX',
	conf_dt COMMENT 'Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE',
	conf_tm COMMENT 'Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME',
	curr_tm COMMENT 'Matches to the current time',
	conf_ts COMMENT 'Confirmation timestamp',
	conf_hr COMMENT 'Confirmation hour',
	hu_fg COMMENT 'Handling Unit Warehouse Task - Technical name: FLGHUTO - Component Type: /SCWM/FLGHUTO',
	src_strg_bin COMMENT 'Source Storage Bin - Technical name: VLPLA - Component Type: /SCWM/LTAP_VLPLA',
	src_hu COMMENT 'Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	hu_type COMMENT 'Type of HU',
	hu_size COMMENT 'EP value of HU',
	rsrc_type COMMENT 'Type of resource',
	QUEUE COMMENT 'Queue',
	src_strg_type COMMENT 'Source Storage Type - Technical name: VLTYP - Component Type: /SCWM/LTAP_VLTYP',
	src_rsrc COMMENT 'Source Resource (Means of Transport or User) - Technical name: SRSRC - Component Type: /SCWM/DE_SRSRC',
	dest_strg_bin COMMENT 'Destination Storage Bin - Technical name: NLPLA - Component Type: /SCWM/LTAP_NLPLA',
	dest_hu COMMENT 'Destination Handling Unit - Technical name: NLENR - Component Type: /SCWM/LTAP_NLENR',
	OWNER COMMENT 'Owner - Technical name: OWNER - Component Type: /SCWM/DE_OWNER',
	dest_strg_type COMMENT 'Destination Storage Type - Technical name: NLTYP - Component Type: /SCWM/LTAP_NLTYP',
	dest_rsrc COMMENT 'Destination Resource (Means of Transport or User) - Technical name: DRSRC - Component Type: /SCWM/DE_DRSRC',
	gr_dt COMMENT 'Goods Receipt Date - Technical name: GRDATE - Component Type: /SCWM/DE_GR_DATE',
	gr_proc_tm COMMENT 'Goods Receipt Processing Time - Technical name: GRTIME - Component Type: /SCWM/DE_GR_TIME',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at',
	receipt_fg COMMENT 'Receipt flag for counted pallets',
	putaway_fg COMMENT 'Putaway flag for picked up palltes',
	tm_on_lane_sec COMMENT 'Time of pallets on lane between receipt and putaway in seconds for average and median time',
	cum_pallets_counted COMMENT 'Amount of pallets in receipts cumulated per group of client, warehouse, day, hour and destination storage type',
	cum_pallets_pickedup COMMENT 'Amount of pallets in putaways cumulated per group of client, warehouse, day, hour and destination storage type',
	cum_pallets_on_lane COMMENT 'Amount of pallets on lane cumulated per group of client, warehouse, day, hour and destination storage type',
	open_ptwy COMMENT 'Open_ptwy KPI (placeholder)',
	open_ptwy_per_hour COMMENT 'Open_ptwy KPI per Hour (placeholder)',
	nums COMMENT 'Amount of hours since the start of the day (placeholder)',
	time_on_lane_m_h COMMENT 'Average time of lane per minute (based on this day, placeholder)'
) COMMENT='SAP EWM Performance Putaway view (based on v_sapewm_whtask)'
 AS
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
	,curr_tm
	,conf_ts
	,conf_hr
	,hu_fg
	,src_strg_bin
	,src_hu
	,hu_type
	,hu_size
	,rsrc_type
	,QUEUE
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
	,tm_on_lane_sec
	,cum_pallets_counted
	,cum_pallets_pickedup
	,cum_pallets_on_lane
	,open_ptwy
	,open_ptwy_per_hour
	,nums
	,time_on_lane_m_h
FROM fe_mstr_logop.v_sapewm_gpl_performance_putaway_add;