/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_laneandloading_2
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE DATA.t_sapewm_laneandloading_2 (
	client_id 							NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code', 
	lidl_country 						VARCHAR(3) 		NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila', 
	source_system 						VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id								NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	tu_num								VARCHAR(18)		NOT NULL 	COMMENT 'Internal Number of Transportation Unit_2',
	status_2                              VARCHAR(5)      NULL 	 	COMMENT 'Status_2 Type',
	zz_stage_date                       DATE            NULL 	 	COMMENT 'Stage date',
	zz_stage_time                       TIME(0)         NULL 	 	COMMENT 'Stage time',
	store                               VARCHAR(10)     NOT NULL 	COMMENT 'Business Partner Number',
	stp_description                     VARCHAR(40)     NULL 	 	COMMENT 'Name 1 of organization',
	real_hus_ep                         NUMBER(38,2)    NULL 	 	COMMENT 'FLS Real HUs',
	planned_hus_ep                      NUMBER(38,2)    NULL 	 	COMMENT 'FLS PSHUs',
	lane1                               VARCHAR(18)     NULL 	 	COMMENT 'Lane 1',
	lane2                               VARCHAR(18)     NULL 	 	COMMENT 'Lane 2',
	lane3                               VARCHAR(18)     NULL 	 	COMMENT 'Lane 3',
	staging_status_icon                 VARCHAR(4)      NULL 	 	COMMENT 'Staging Status_2',
	reshuffle                           VARCHAR(4)      NULL 	 	COMMENT 'Reshuffle necessary',
	reshuffle_task                      VARCHAR(4)      NULL 	 	COMMENT 'Open reshuffle tasks',
	overall_picking_status_icon         VARCHAR(4)      NULL 	 	COMMENT 'Picking Status_2',
	assigned_doors                      VARCHAR(48)     NULL 	 	COMMENT 'Assigned Doors',
	lgnum                               VARCHAR(4)      NOT NULL 	COMMENT 'Warehouse Number/Warehouse Complex',
	tu_sr_act_num                       NUMBER(38,0)    NULL 	 	COMMENT 'Shipping and Receiving Activity Number: Transportation Unit_2',
	lic_plate                           VARCHAR(20)     NULL 	 	COMMENT 'License Plate Number for Transportation Unit_2',
	tsp_curr                            VARCHAR(10)     NULL 	 	COMMENT 'Carrier',
	frd_num                             VARCHAR(35)     NULL 	 	COMMENT 'Freight Document Number',
	fixed_pallets                       NUMBER(38,2)    NULL 	 	COMMENT 'FLS Fix Pallets',
	real_hus                            NUMBER(38,2)    NULL 	 	COMMENT 'Amount of Real HUs',
	planned_hus                         NUMBER(38,2)    NULL 	 	COMMENT 'Amount of PSHUs',
	ca_active                           BOOLEAN		    NULL 	 	COMMENT 'Chiller-ambient active',
	stag                                VARCHAR(4)      NOT NULL 	COMMENT 'Staging Area Group',
	lane4                               VARCHAR(18)     NULL 	 	COMMENT 'Lane 4',
	stag_capacity_status_icon           VARCHAR(4)      NULL 	 	COMMENT 'Stage capacity status_2',
	stag_bay_change_icon                VARCHAR(4)      NULL 	 	COMMENT 'Staging Bay Change Indicator',
	total_fls                           NUMBER(38,2)    NULL 	 	COMMENT 'FLS Total',
	fs_offset                           NUMBER(38,2)    NULL 	 	COMMENT 'FLS Offset',
	overall_staging_status              VARCHAR(4)      NULL 	 	COMMENT 'Overall Staging Status_2',
	overall_picking_status              VARCHAR(4)      NULL 	 	COMMENT 'Overall Picking Status_2',
	gi_status                           VARCHAR(4)      NULL 	 	COMMENT 'GI Status_2',
	dwh_load_id 						NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created							TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated							TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	PRIMARY KEY (client_id, lgnum, tu_num, store, stag)
) COMMENT = 'SAP EWM - Header for CAP2 monitor node lane and loading'
;