/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_wawi_stock_corr
Description		|	WAWI table
====================================================================================================
*/

CREATE TABLE DATA.t_wawi_stock_corr (
client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code', 
wh_id				NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse number. Original name: wh_nr',
wawi_instanz_kzl 	VARCHAR(3) 		NOT NULL 	COMMENT 'Country code',
form_nr				NUMBER(38,0)	NOT NULL 	COMMENT 'Document number',
form_date 			DATE   			NULL 	 	COMMENT 'End of day date',
item_nr				VARCHAR(18) 	NULL 	 	COMMENT 'Item number',
item_desc 			VARCHAR(100)	NULL 	 	COMMENT 'Item name',
reason_id 			VARCHAR(20) 	NULL 	 	COMMENT '',
reason_desc			VARCHAR(254)	NULL 	 	COMMENT 'Reason for inventory change',
stc_val_flag		NUMBER(38,0)	NULL 	 	COMMENT '',
case_qty 			NUMBER(38,0)	NULL 	 	COMMENT 'Inventory change',
tg_status 			NUMBER(38,0)	NULL 	 	COMMENT '',
mod_user 			VARCHAR(8)  	NULL 	 	COMMENT 'User who made changes',
mod_date 			TIMESTAMP   	NULL 	 	COMMENT 'Date of change',
decimal_case 		NUMBER(38,3) 	NULL 	 	COMMENT '',
piece_qty 			NUMBER(38,3)	NULL 	 	COMMENT 'Piece quantity',
form_nr_ref 		VARCHAR(25) 	NULL 	 	COMMENT 'Formno ref (e.g. EWM Formno)',
ewm_form_date 		DATE   			NULL 	 	COMMENT 'EWM Formdate',
act_price_gross 	NUMBER(38,3)	NULL 	 	COMMENT 'Actual Price Gross',
act_price_net 		NUMBER(38,3)	NULL 	 	COMMENT 'Actual Price Net',
value_gross 		NUMBER(38,3)	NULL 	 	COMMENT 'Value Gross',
value_net 			NUMBER(38,3)	NULL 	 	COMMENT 'Value net',
charge 				VARCHAR(35) 	NULL 	 	COMMENT 'C067_CHARGE',
scn 				NUMBER(38,0)	NULL 	 	COMMENT '',
dwh_load_id    		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created    		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated    		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 		DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to   		DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg     		BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id, wh_id, form_nr, dwh_valid_from)
) COMMENT = 'WAWI - WHWAWIADM.T067_STOCK_CORR table'
;