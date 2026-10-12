/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_area
Description		|	LPV source table
====================================================================================================
*/

CREATE TABLE DATA.t_lpv_area (
	client_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code',
	lidl_country 	VARCHAR(4) 		NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila',
	source_system 	VARCHAR(30)		NOT NULL 	COMMENT 'Source_system: LPV',
	wh_id 			NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',	
	area_nr 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Area number. Original name - NR',
	area_descr 		VARCHAR(50) 	NULL		COMMENT 'Area description. Original name - BEZ',		
	reserve_area_nr	NUMBER(38,0) 	NULL 		COMMENT 'Location ID of the reserve area. FK: References LPV.BEREICH.NR. Original name - RESBEREICH',
	dwh_load_id 	NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created 	TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated 	TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 	DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to 	DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg 		BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, area_nr, dwh_valid_from)
) COMMENT = 'LPV - This table saves areas of the warehouse modelling.(Bereich)'
; 