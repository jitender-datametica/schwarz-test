/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_ast_2
Description		|	LPV source table
====================================================================================================
*/

CREATE TABLE DATA.t_lpv_ast_2 (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code',
	lidl_country 			VARCHAR(4) 		NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila',
	source_system 			VARCHAR(30)		NOT NULL 	COMMENT 'Source_system: LPV',
	wh_id 					NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	article_nr				VARCHAR(20)		NOT NULL 	COMMENT 'Article number. PK. Original name - ANR',
	article_descr     		VARCHAR(50)     NULL 	 	COMMENT 'Article name. Original name - KTXT',
	article_unit_name       VARCHAR(10)     NULL 	 	COMMENT 'Artcile unit_2 name. Original name - UNIT_2',
	abc_id                  VARCHAR(1)      NULL 	 	COMMENT 'ABC indicator. Original name - ABC',
	bbd_obligation_id       NUMBER(38,0)    NULL 	 	COMMENT 'BBD obligation indicator. Original name - ERFASSE_MHD',
	weight_qty              NUMBER(38,0)    NULL 	 	COMMENT 'Weight of one unit_2 in gram. Original name - GEWICHT',
	quantity_unit2          NUMBER(38,0)    NULL 	 	COMMENT 'Number of units for each packaging unit_2 2. Original name - ANZAHL_VPE2',
	name_unit2              VARCHAR(10)     NULL 	 	COMMENT 'Name of packaging unit_2 2. Original name - NAME_VPE2',
	batch_obligation_id     NUMBER(38,0)    NULL 	 	COMMENT 'Batch oligation indicator. Original name - CHARGENPFLICHTIG',
	v1_attribute            NUMBER(38,0)    NULL 	 	COMMENT 'Article attribute. Must be stored on a storage location_2 with matching WHX.V1. Original name - V1',
	v2_item_group           NUMBER(38,0)    NULL 	 	COMMENT 'Item_2 group. Original name - V2',
	v3_article_family       NUMBER(38,0)    NULL 	 	COMMENT 'Article family. Original name - V3',
	v4_rlz                  NUMBER(38,0)    NULL 	 	COMMENT 'Minimum days before the BBD is reached (Restlaufzeit). Original name - V4',
	fefo_tolerance          NUMBER(38,0)    NULL 	 	COMMENT 'Configured FEFO tolerance in percentage. Original name - FEFOTOLERANZ',
	fifo_tolerance          NUMBER(38,0)    NULL 	 	COMMENT 'Configured FIFO tolerance in percentage. Original name - FIFOTOLERANZ',
	country_of_origin       VARCHAR(3)      NULL 	 	COMMENT 'Country_2 of origin. Original name - URSPRUNGSLAND',
	creation_tmsp      		TIMESTAMP	    NULL 	 	COMMENT 'Time of record creation. Original name - ANLAGEZEIT',
	change_tmsp		        TIMESTAMP	    NULL 	 	COMMENT 'Time of last record change. Original name - HOSTAENDERUNGSZEIT',	
	dwh_load_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created 			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated 			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to 			DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg 				BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, article_nr, dwh_valid_from)
) COMMENT = 'LPV - This table saves article master data, that is communicated from the WaWi via WMI.'
; 