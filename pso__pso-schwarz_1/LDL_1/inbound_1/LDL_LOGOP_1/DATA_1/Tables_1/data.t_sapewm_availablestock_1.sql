/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_availablestock_1
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE DATA.t_sapewm_availablestock_1 (
	client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code', 
	lidl_country 		VARCHAR(3) 		NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila', 
	source_system 		VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id				NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	lgnum				VARCHAR(5)		NOT NULL	COMMENT 'Warehouse Number/Warehouse Complex',
	lgtyp               VARCHAR(4)      NULL        COMMENT 'Storage Type',
	lgpla               VARCHAR(18)     NOT NULL    COMMENT 'Storage Bin',
	logpos              VARCHAR(2)      NULL        COMMENT 'Logical Position of Handling Unit_1',
	rsrc                VARCHAR(18)     NULL        COMMENT 'Resource (Means of Transportation or User)',
	tu_num              VARCHAR(18)     NULL        COMMENT 'Internal Number of Transportation Unit_1',
	tu_num_ext          VARCHAR(20)     NULL        COMMENT 'Transportation Unit_1',
	tsp                 VARCHAR(10)     NULL        COMMENT 'Carrier',
	guid_parent         VARCHAR(50)     NULL        COMMENT 'Parent GUID',
	guid_stock          VARCHAR(50)     NOT NULL    COMMENT 'GUID Stock Item_1',
	huident             VARCHAR(20)     NOT NULL    COMMENT 'Handling Unit_1 Identification',
	matid               VARCHAR(50)     NULL        COMMENT 'Product',
	matnr               VARCHAR(40)     NOT NULL    COMMENT 'Product',
	maktx               VARCHAR(40)     NULL        COMMENT 'Product Short Description',
	quan                NUMBER(38,3)    NULL        COMMENT 'Quantity',
	unit_1                VARCHAR(3)      NULL        COMMENT 'Base Unit_1 of Measure',
	cat                 VARCHAR(2)      NULL        COMMENT 'Stock Type',
	cat_txt             VARCHAR(30)     NULL        COMMENT 'Description of Stock Type',
	charg               VARCHAR(10)     NOT NULL    COMMENT 'Batch',
	brestr              BOOLEAN         NULL        COMMENT 'Batch in Restricted-Use Stock',
	coo                 VARCHAR(3)      NULL        COMMENT 'Country_1 of Origin',
	OWNER               VARCHAR(10)     NULL        COMMENT 'Owner',
	entitled            VARCHAR(10)     NOT NULL    COMMENT 'Party Entitled to Dispose',
	stock_usage         VARCHAR(1)      NULL        COMMENT 'Stock Usage',
	stock_doccat        VARCHAR(3)      NULL        COMMENT 'Type: Sales_1 Order Stock or Project Stock',
	stock_docno         VARCHAR(35)     NULL        COMMENT 'Number of the Sales_1 Order or Project for Special Stock',
	stock_itmno         NUMBER(38,0)    NULL        COMMENT 'Sales_1 Order Item_1 for Sales_1 Order Stock',
	insptyp             VARCHAR(1)      NULL        COMMENT 'Inspection ID Type',
	inspdocno           VARCHAR(35)     NULL        COMMENT 'QIE Entity: External Identification',
	vfdat               DATE            NULL        COMMENT 'Shelf Life Expiration Date',
	ui_wdatt            TIME(0)         NOT NULL    COMMENT 'Goods Receipt Time',
	ui_wdatu            DATE            NOT NULL    COMMENT 'Goods Receipt Date',
	skzsi               BOOLEAN         NULL        COMMENT 'Blocking Indicator: Current Inventory (System)',
	outcon              VARCHAR(1)      NULL        COMMENT 'Storage Bin Improvable',
	dummy_field         VARCHAR(1)      NULL        COMMENT 'Dummy_1 function in length 1',
	zeugn               VARCHAR(10)     NULL        COMMENT 'Certificate Number',
	psa                 VARCHAR(15)     NULL        COMMENT 'Production Supply Area',
	doccat              VARCHAR(3)      NULL        COMMENT 'Doc. Category for Doc. Reference and Doc.-Related Stocks',
	quana               NUMBER(38,3)    NULL        COMMENT 'Available Quantity in Alternative Unit_1 of Measure',
	altme               VARCHAR(3)      NULL        COMMENT 'Alternative Unit_1 of Measure for Stockkeeping Unit_1',
	flgmove             BOOLEAN         NULL        COMMENT 'Indicator: Handling Unit_1 is Being Moved (Open HU WT)',
	dwh_load_id    		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 		DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   		DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     		BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, lgnum, huident, matnr, ui_wdatu, ui_wdatt, charg, lgpla, guid_stock, entitled, dwh_valid_from)
) COMMENT = 'SAP EWM - Overview of Available Stock Monitor'
;