/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_bestand_1
Description		|	LPV source table
====================================================================================================
*/

CREATE TABLE DATA.t_lpv_bestand_1 (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code', 
	lidl_country 			VARCHAR(3) 		NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila', 
	source_system 			VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id 					NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	stock_id				VARCHAR(20)		NOT NULL 	COMMENT 'Surrogate key: Internal ID. Primary key. Original name - bestandid',
	src_pallet_nr           VARCHAR(30)     NULL 	 	COMMENT 'Number of the pallet on which the stock is located. Original name - lhmnr',
	article_nr		        VARCHAR(20)     NULL 	 	COMMENT 'Article number. Original name - anr',
	batch                   VARCHAR(30)     NULL 	 	COMMENT 'Batch. Original name - charge',
	src_qty	                NUMBER(38,0)    NULL 	 	COMMENT 'Quantity (number of pieces of unit_1 AST.VPE1). May be multiplied in order to display decimal places according to the global setting MengenFakt. Original name - menge',
	available_qty		    NUMBER(38,0)    NULL 	 	COMMENT 'Available quantity. Quantities will be reserved as soon as warehouse orders for movements and replenishments are created. In such cases the value MENGE_V will be smaller than MENGE. Original name - menge_v',
	status_1                  VARCHAR(3)      NULL 	 	COMMENT 'Indicates whether the stock is blocked. 2nd letter indicated whether the stock is inventoried. Original name - status_1',
	gr_date                 DATE            NULL 	 	COMMENT 'GR date. Original name - datum',
	src_area_nr             NUMBER(38,0)    NULL 	 	COMMENT 'Number of the area the stock is currently located in. Original name - bereich',
	gr_id                   NUMBER(38,0)    NULL 	 	COMMENT 'LPV-internal number of the goods receipt. Original name - weidnr',
	change_dt		        DATE            NULL 	 	COMMENT 'Last change of the record. Original name - letzter_zugriff',
	supplier_1                VARCHAR(40)     NULL 	 	COMMENT 'Supplier_1 of the article (communicated by eGIN via WMI). Original name - lieferant',
	weight                  NUMBER(38,0)    NULL 	 	COMMENT 'Stock weight in g. The number is multiplied with 1000. Original name - gewicht',
	p1_egin_task_id         VARCHAR(70)     NULL 	 	COMMENT 'eGIN task ID. Original name - p1',
	p2_gr_position          VARCHAR(70)     NULL 	 	COMMENT 'Position at the gate during counting (in order to load 3 consecutive pallets onto a fast mover). Original name - p2',
	p3_gr_priority          VARCHAR(70)     NULL 	 	COMMENT 'Priority. Default: 50. Missing item_1: 1. Original name - p3',
	p4_pallet_factor        VARCHAR(70)     NULL 	 	COMMENT 'Pallet factor. Original name - p4',
	p5_best_before_dt       DATE     		NULL 	 	COMMENT 'Best before date. Original name - p5',
	p6_filling_year         NUMBER(38,0)    NULL 	 	COMMENT 'Filling year. May be empty for most articles. Original name - p6',
	p7_gr_id                VARCHAR(70)     NULL 	 	COMMENT 'GR ID. Original name - p7',
	p8_special_offer        VARCHAR(70)     NULL 	 	COMMENT 'Special offers indicator (German: Aktionsware). Original name - p8',
	p9                      VARCHAR(70)     NULL 	 	COMMENT 'Not used in LPV 8. Original name - p9',
	p10                     VARCHAR(70)     NULL 	 	COMMENT 'Not used in LPV 8. Original name - p10',
	delivery_dt	            DATE            NULL 	 	COMMENT 'Latest delivery date, calculated with BESTAND.P5 - AST.V4 (BBD - Minimum days before the BBD is reached / Restlaufzeit). Original name - mhd',
	dwh_load_id    			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   			DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, stock_id, dwh_valid_from)
) COMMENT = 'LPV - This table saves stock quantities and information.'
;