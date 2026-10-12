/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_tabakt_1
Description		|	LPV source table
====================================================================================================
*/

CREATE TABLE DATA.t_lpv_tabakt_1 (
	client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code',
	lidl_country 		VARCHAR(3) 		NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila',
	source_system 		VARCHAR(30)		NOT NULL 	COMMENT 'Source system',
	wh_id 				NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number(lagernummer)',
	operation_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Surrogate key. Original name - REIHE',
	operation_tmsp 		TIMESTAMP 		NULL 		COMMENT 'Time stamp in format \"YYYYMMDDHH24MiSS\". Original name - STAMPNR',
	operation_type 		VARCHAR(2) 		NULL 		COMMENT 'Operation type. Original name - OPERATION',
	user_id 			VARCHAR(9) 		NULL 		COMMENT 'User ID of the executing user. Foreign key: Referencing LPV.PERSONAL.PERSNR. Original name - PERSNR',
	article_nr 			VARCHAR(20) 	NULL 		COMMENT 'Article number. Foreign key: References LPV.AST.ANR. Original name - ANR',
	src_qty 			NUMBER(38,0) 	NULL 		COMMENT 'Quantity (cf. explantion for table LPV.BESTAND in order to correctly interpret this number). Original name - MENGE',
	tgt_qty 			NUMBER(38,0) 	NULL 		COMMENT 'Target quantity. Original name - SOLLMENGE',
	stock_id			VARCHAR(20) 	NULL 		COMMENT 'Stock ID. Foreign key: References LPV.BESTAND.BESTANDID. Original name - BESTANDID',
	gr_id 				NUMBER(38,0) 	NULL 		COMMENT 'LPV-internal number of the goods receipt. Original name - WEIDNR',
	batch 				VARCHAR(30) 	NULL 		COMMENT 'Batch. Original name - CHARGE',
	p1_egin_task_id 	VARCHAR(70) 	NULL 		COMMENT 'eGIN task ID. Original name - P1',
	p2_gr_position 		VARCHAR(70) 	NULL 		COMMENT 'Position at the gate during counting. Original name - P2',
	p3_gr_priority 		VARCHAR(70) 	NULL 		COMMENT 'Priority. Original name - P3',
	p4_pallet_factor 	VARCHAR(70) 	NULL 		COMMENT 'Pallet factor. Original name - P4',
	p5_best_before_dt 	DATE 			NULL 		COMMENT 'Best before date in Format \"YYYYMMDD\". Original name - P5',
	p6_filling_year 	NUMBER(38,0) 	NULL 		COMMENT 'Filling year in Format \"YYYY\". May be empty for most articles.. Original name - P6',
	p7_gr_id 			VARCHAR(70) 	NULL 		COMMENT 'GR ID. Original name - P7',
	p8_special_offer 	VARCHAR(70) 	NULL 		COMMENT 'Special offers indicator (German: Aktionsware). Original name - P8',
	p9 					VARCHAR(70) 	NULL 		COMMENT 'Not used in LPV 8. Original name - P9',
	p10 				VARCHAR(70) 	NULL 		COMMENT 'Not used in LPV 8. Original name - P10',
	src_area_nr 		NUMBER(38,0)	NULL 		COMMENT 'Source area. Foreign key: Referencing LPV.BEREICH.NR. Original name - BEREICH',
	src_location_id 	VARCHAR(11) 	NULL 		COMMENT 'Source location_1 ID. Foreign key: Referencing LPV.WHX.ORT. Original name - ORT',
	src_pallet_nr 		VARCHAR(30) 	NULL 		COMMENT 'Number of the pallet on which the stock is located. Foreign key: References LPV.LHM.LHMNR. Original name - LHMNR',
	tgt_area_nr 		NUMBER(38,0)	NULL 		COMMENT 'Target area. Foreign key: Referencing LPV.BEREICH.NR. Original name - ZIELBEREICH',
	tgt_location_id 	VARCHAR(11) 	NULL 		COMMENT 'Target location_1 ID, may be empty. Foreign key: Referencing LPV.WHX.ORT. Original name - ZIELORT',
	tgt_pallet_nr 		VARCHAR(30) 	NULL 		COMMENT 'Target pallet number. Foreign key: References LPV.LHM.LHMNR. Original name - ZIELLHMNR',
	computer_id 		VARCHAR(15) 	NULL 		COMMENT 'Computer that initiated the goods movement. Foreign key: References LPV.RECHNER.RECHNERID. Original name - RECHNERID',
	delivery_dt 		DATE 			NULL 		COMMENT 'Delivery date. Original name - MHD',
	dwh_load_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created 		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated 		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 		DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to 		DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg 			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, operation_id, dwh_valid_from)
) COMMENT = 'LPV - This table saves all stock movements and withdrawals.'
;