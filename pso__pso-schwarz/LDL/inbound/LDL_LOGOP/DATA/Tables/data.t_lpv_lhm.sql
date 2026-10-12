/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_lhm
Description		|	LPV source table
====================================================================================================
*/

CREATE TABLE DATA.t_lpv_lhm (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code', 
	lidl_country 			VARCHAR(3) 		NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila', 
	source_system 			VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id 					NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	location_id    			VARCHAR(11)		NULL 	 	COMMENT 'Internal location ID of the pallets current location. FK: Referencing LPV.WHX.ORT. Original name - ORT',
	pallet_nr           	VARCHAR(30)     NOT NULL 	COMMENT 'Pallet number. Primary key. Original name - LHMNR',
	height                  NUMBER(38,0)    NULL 	 	COMMENT 'Height of the pallet in mm. Original name - HOEHE',
	pallet_type             NUMBER(38,0)    NULL 	 	COMMENT 'Pallet type. Original name - STELLTYP',
	article_nr          	VARCHAR(20)     NULL 	 	COMMENT 'Article number. FK: References LPV.AST.ANR. Original name - ANR',
	status_cd               VARCHAR(1)      NULL 	 	COMMENT 'Availability status. Original name - STATUS',
	dwh_load_id    			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   			DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, pallet_nr, dwh_valid_from)
) COMMENT = 'LPV - This table saves pallet information.'
;