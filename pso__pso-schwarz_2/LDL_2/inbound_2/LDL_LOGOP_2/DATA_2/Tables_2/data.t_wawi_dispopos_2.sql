CREATE TABLE DATA.T_WAWI_DISPOPOS_2 (
client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code', 
wawi_instanz_kzl 		VARCHAR(3)		NOT NULL 	COMMENT 'Country_2 code',
wh_nr 					NUMBER(38,0)  	NOT NULL 	COMMENT 'Warehouse number',

po_nr 					VARCHAR(12) 	NOT NULL	COMMENT 'Order number: supplier_2 number (4), delivery date (6), consecutive number (2)',
artikelnr 				VARCHAR(18) 	NOT NULL	COMMENT 'nine-digit article number - ARTICLE.Article no',
lfdnr 					NUMBER(38,0) 	NOT NULL	COMMENT 'The ORADBC W00.00.37 changes the data format from Number (2.0) to Number (3.0) - WEPOS.DispoLfdNrArtikel',
disponr 				NUMBER(38,0) 	NULL		COMMENT 'Order quantity unit_2: 0 = boxes; 1 = layer; 2 = Düsseldorf; 3 = pallet; 4 = piece (not supported by DIS); Is recoded via table DISPOEINHEIT_2',
menge 					NUMBER(38,0) 	NULL		COMMENT 'Order quantity in order unit_2',
liefdatum 				TIMESTAMP 		NULL		COMMENT 'Delivery date',
liefzeit 				TIMESTAMP 		NULL		COMMENT 'Time for delivery',
menge2 					NUMBER(38,0) 	NULL		COMMENT 'Received quantity for GR split. Is filled by eGIN for partial deliveries',
datum 					TIMESTAMP 		NULL		COMMENT 'Creation date',
bediener 				VARCHAR(8) 		NULL		COMMENT 'User (replenishment planner)',
datumm2 				TIMESTAMP 		NULL		COMMENT 'Change date QUANTITY2',
bedienerm2 				VARCHAR(8) 		NULL		COMMENT 'User QUANTITY2. Is filled by eGIN for partial deliveries',
knzteil 				NUMBER(38,0) 	NULL		COMMENT 'Is filled by eGIN for partial deliveries. Default value = 0',
status_2 					NUMBER(38,0) 	NULL		COMMENT '0 = order open; 1 = order after quantity correction; 2 = order closed; 9 = Order deleted',
kartonfakt 				NUMBER(38,0) 	NULL		COMMENT 'Pallet factor of the ordered order unit_2',
diff_we 				NUMBER(38,0) 	NULL		COMMENT '',
c126_org_order_qty 		NUMBER(38,10) 	NULL		COMMENT 'Delivery quantity',
c126_org_del_date 		TIMESTAMP 		NULL		COMMENT 'Delivery date',
c126_taskid 			NUMBER(38,0) 	NULL		COMMENT 'Is filled by eGIN as part of the WE',
c126_deltime_until 		TIMESTAMP 		NULL		COMMENT 'Delivery time',
c126_decimalcase 		NUMBER(38,3) 	NULL		COMMENT 'Decimal case content',
c126_desadv_comment 	VARCHAR(500) 	NULL		COMMENT 'Free text in which the dispatchers can maintain how the difference should be handled. Is displayed in eGIN during clarification with the MRP information flag.',
c126_desadv_status 		NUMBER(38,0) 	NULL		COMMENT 'Status_2 DESADV (in the context of clarification of differences). Comment that is maintained by SC as part of the clarification of differences between DESADV and ORDER',
scn 					NUMBER(38,0)	NULL		COMMENT '',

dwh_load_id    			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created    			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated    			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to   			DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg     			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id, wh_nr, po_nr, artikelnr, lfdnr, dwh_valid_from)
) COMMENT = 'WAWI - WHWAWIADM.DISPOPOS.';



