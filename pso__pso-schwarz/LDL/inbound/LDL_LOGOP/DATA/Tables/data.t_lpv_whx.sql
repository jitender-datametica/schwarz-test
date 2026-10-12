/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_whx
Description		|	LPV source table
====================================================================================================
*/

CREATE TABLE DATA.t_lpv_whx (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code', 
	lidl_country 			VARCHAR(3) 		NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila', 
	source_system 			VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id 					NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	location_id        		VARCHAR(11)		NOT NULL 	COMMENT 'Internal location number. Primary key. Original name - ORT',
	location_name           VARCHAR(20)     NULL 	 	COMMENT 'Location label. Original name - BEZ',
	LENGTH                  NUMBER(38,0)    NULL 	 	COMMENT 'Location length in cm. Original name - LAENGE',
	width                   NUMBER(38,0)    NULL 	 	COMMENT 'Location width in cm. Original name - BREITE',
	height                  NUMBER(38,0)    NULL 	 	COMMENT 'Location height in cm. Original name - HOEHE',
	area_nr                 NUMBER(38,0)    NULL 	 	COMMENT 'Number of the area the stock is currently located in. FK: References LPV.BEREICH.NR. Original name - BEREICH',
	block_cd                VARCHAR(1)      NULL 	 	COMMENT 'Whether the location is currently locked. V = No block. S = Blocked. Original name - SPERRE',
	capacity                NUMBER(38,0)    NULL 	 	COMMENT 'Location capacity. Original name - PLATZ',
	capacity_available      NUMBER(38,0)    NULL 	 	COMMENT 'Free location capacity. Original name - PLATZ_V',
	max_weight              NUMBER(38,0)    NULL 	 	COMMENT 'Maximum weight in kg. The number is multiplied with 1000. Original name - MAXGEW',
	picking_indicator       NUMBER(38,0)    NULL 	 	COMMENT 'Indicator whether the location is assigned to an article as a picking laction (table LPV.ASTBER). Original name - FIXPLATZ',
	v1_attribute            NUMBER(38,0)    NULL 	 	COMMENT 'Article attribute. Original name - V1',
	v3_location_type        NUMBER(38,0)    NULL 	 	COMMENT 'Storage location type. Original name - V3',
	dwh_load_id    			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   			DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, location_id, dwh_valid_from)
) COMMENT = 'LPV - This table saves storage locations including gates and special locations like terminals.'
;