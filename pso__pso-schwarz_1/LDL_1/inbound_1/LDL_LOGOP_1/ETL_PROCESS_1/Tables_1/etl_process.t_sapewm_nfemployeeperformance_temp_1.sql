/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_sapewm_nfemployeeperformance_temp_1
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_sapewm_nfemployeeperformance_temp_1 (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code', 
	lidl_country 			VARCHAR(3) 		NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila', 
	source_system 			VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id					NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	lgnum					VARCHAR(5)		NOT NULL	COMMENT 'Warehouse Number/Warehouse Complex',
	zz_werks                VARCHAR(4)      NULL        COMMENT 'Store',
	zz_kw                   VARCHAR(2)      NULL        COMMENT 'Calendar_1 week',
	zz_refbs                VARCHAR(10)     NULL        COMMENT 'Return number',
	huident                 VARCHAR(20)     NULL        COMMENT 'Handling Unit_1 Identification',
	productno               VARCHAR(40)     NULL        COMMENT 'Product Number',
	defect                  BOOLEAN         NULL        COMMENT 'Flag: Is defect',
	art_unknown             BOOLEAN         NULL        COMMENT 'Flag: Is article unknown',
	is_in_ret               BOOLEAN         NULL        COMMENT 'Flag: Is in return',
	sps                     BOOLEAN         NULL        COMMENT 'Flag: Is Special Sales_1',
	matnr_dummy             VARCHAR(40)     NULL        COMMENT 'Dummy_1 material number',
	repeat_qty              NUMBER(38,14)   NULL        COMMENT 'Quantity Field',
	uom                     VARCHAR(3)      NULL        COMMENT 'Unit_1 of Measure',
	station_id              VARCHAR(10)     NULL        COMMENT 'Id of Scan Station in NF counting process',
	station_id_prep         VARCHAR(10)     NULL        COMMENT 'Id of Scan Station in NF preparation process',
	created_date            DATE            NOT NULL    COMMENT 'Created On',
	created_time            TIME(0)         NULL        COMMENT 'Created At',
	creusr                  VARCHAR(12)     NULL        COMMENT 'Created By',
	NAME                    VARCHAR(80)     NULL        COMMENT 'Full Name of Person',
	undo_set                BOOLEAN         NULL        COMMENT 'Undo flag',
	offline_srt             BOOLEAN         NULL        COMMENT 'Offline Sorting',
	scan_guid				VARCHAR(50)     NULL        COMMENT 'Scan ID',
	ean11					VARCHAR(18)     NULL        COMMENT 'Data Element:  International Article Number',
	sort_req				BOOLEAN		    NULL        COMMENT 'SORT REQ',
	is_unpacked				VARCHAR(1)      NULL        COMMENT 'Is unpacked',
	dwh_load_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created				TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated				TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at'
) COMMENT = 'SAP EWM - Employee_1 Performance'
;