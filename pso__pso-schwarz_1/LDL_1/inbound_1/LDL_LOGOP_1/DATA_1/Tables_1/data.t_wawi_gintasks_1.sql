/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_wawi_gintasks_1
Description		|	WAWI table
====================================================================================================
*/

CREATE TABLE DATA.t_wawi_gintasks_1 (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code', 
	wh_nr 					NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse number',
	wawi_instanz_kzl 		VARCHAR(3) 		NOT NULL	COMMENT 'Country_1 code',
	task_id 				NUMBER(38,0) 	NOT NULL	COMMENT 'Unique ID of the task.',
	view_task_id 			NUMBER(38,0)	NULL 		COMMENT '',
	gin_gate 				NUMBER(38,0)	NULL 		COMMENT 'Gate that has been assigned to the task. A task does not necessarily have to be assigned to a gate.',
	gate_type_id			NUMBER(38,0)	NULL 		COMMENT '',
	carrier 				VARCHAR(30)		NULL 		COMMENT 'Shipping company that delivers.',
	task_status				NUMBER(38,0)	NULL 		COMMENT 'Status_1 of the task: 0: recorded / in process (not used); 10: free for counting; 20: Locked, i.e. currently counting; 21: Locked; has differences; 29: Counting data and pallet data have been transferred, but there are still differences (for WE manager processing); 30: Counting finished, free for reprocessing; 40: Not accepted for reprocessing (i.e. deleted). The task is no longer displayed; 90: deleted; 99: Completed, i.e. WE have been created.',
	priority 				NUMBER(38,0)	NULL 		COMMENT 'Specifies whether the task should be given preferential treatment. Is used for display on the MDE.',
	ponr 					VARCHAR(12)		NULL 		COMMENT 'Order number. Empty for bulk deliveries.',
	krednr 					VARCHAR(7)		NULL 		COMMENT 'Supplier_1 number of the order, empty for bulk deliveries',
	kreddesc 				VARCHAR(35)		NULL 		COMMENT 'Supplier_1 name or shipping company for bulk deliveries',
	deliverynote 			VARCHAR(20)		NULL 		COMMENT 'Delivery note number; no longer used.',
	pal_eu_in 				NUMBER(38,0)	NULL 		COMMENT 'Number of empty pallets brought on the truck',
	pal_eu_out 				NUMBER(38,0)	NULL 		COMMENT 'Number of empty pallets that the truck takes back.',
	pal_eu_gs 				NUMBER(38,0)	NULL 		COMMENT 'Number of empty pallets for which the driver receives a pallet voucher.',
	pal_eu_goods 			NUMBER(38,0)	NULL 		COMMENT 'Number of pallets delivered with goods.',
	pal_eu_broken 			NUMBER(38,0)	NULL 		COMMENT 'Number of defective pallets.',
	pal_dd_in 				NUMBER(38,0)	NULL 		COMMENT 'See C173_PAL_EU_IN',
	pal_dd_out 				NUMBER(38,0)	NULL 		COMMENT 'See C173_PAL_EU_OUT',
	pal_dd_gs 				NUMBER(38,0)	NULL 		COMMENT 'See C173_PAL_EU_GS',
	pal_dd_goods 			NUMBER(38,0)	NULL 		COMMENT 'See C173_PAL_EU_GOODS',
	pal_dd_broken 			NUMBER(38,0)	NULL 		COMMENT 'See C173_PAL_EU_BROKEN',
	create_date 			TIMESTAMP		NULL 		COMMENT 'Date and time when the task was created for the first time. If changes are made in the goal allocation mask, the task is completely deleted and recreated. The content of this column is retained!',
	mod_date 				TIMESTAMP		NULL 		COMMENT 'Last change to the task',
	mod_user 				VARCHAR(8)		NULL 		COMMENT '',
	est_pallets 			NUMBER(38,0)	NULL 		COMMENT 'Expected number of pallets. Will be filled from T134 when saving the task.',
	lock_id 				NUMBER(38,10)	NULL 		COMMENT 'IP address_1 of the MDE client that locked the task, in numerical form.',
	pal_eu_diff 			NUMBER(38,0)	NULL 		COMMENT 'Palette difference from the handheld',
	pal_dd_diff 			NUMBER(38,0)	NULL 		COMMENT 'See C173_PAL_EU_DIFF',
	task_type 				NUMBER(38,0)	NULL 		COMMENT '0: eGIN task from normal order; 1: F&V task; 2: Return',
	task_flags 				NUMBER(38,0)	NULL 		COMMENT 'Special task options, partly dependent on the supplier_1: 0x01: Pallet difference permitted; 0x02: FC Task: Early pallet clearing; 4 = TTT (if Palletvoucher in Lidl.ini = 1, then status_1 5',
	container 				VARCHAR(20)		NULL 		COMMENT 'Container number; only for freight forwarders with container logistics and mandatory entry of the number.',
	rcv_lanes 				VARCHAR(35)		NULL 		COMMENT 'CSV list of the WE tracks that were recorded for this task. New for SSI (comma-separated list of the WE tracks on which the article is located',
	terminaljob_id 			NUMBER(38,0)	NULL 		COMMENT '',
	ttt_state 				NUMBER(38,0)	NULL 		COMMENT '',
	scn 					NUMBER(38,0)	NULL 		COMMENT '',
	alma_status 			NUMBER(38,0)	NULL 		COMMENT '',
	lane 					VARCHAR(255)	NULL 		COMMENT '',
	device_manufacturer 	VARCHAR(50)		NULL 		COMMENT '',
	device_model 			VARCHAR(16)		NULL 		COMMENT '',
	device_os_platform 		VARCHAR(16)		NULL 		COMMENT '',
	device_os_version 		VARCHAR(8)		NULL 		COMMENT '',
	device_uuid 			VARCHAR(40)		NULL 		COMMENT '',
	evoucher 				NUMBER(38,0)	NULL 		COMMENT '',
	evoucherpal_eu 			NUMBER(38,0)	NULL 		COMMENT '',
	evoucherpal_dd 			NUMBER(38,0)	NULL 		COMMENT '',
	evouchernr 				VARCHAR(25)		NULL 		COMMENT '',
	driver_info 			NUMBER(38,0)	NULL 		COMMENT '',
	ext_wh 					NUMBER(38,0)	NULL 		COMMENT '',
	lia_reference 			VARCHAR(30)		NULL 		COMMENT '',
	dwh_load_id    			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   			DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_nr, task_id, dwh_valid_from)
) COMMENT = 'WAWI - WHWAWIADM.T173_GINTASKS_1 table.'
;