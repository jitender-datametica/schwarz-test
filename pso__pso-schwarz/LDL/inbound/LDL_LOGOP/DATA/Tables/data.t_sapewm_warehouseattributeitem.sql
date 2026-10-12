/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_warehouseattributeitem
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE DATA.t_sapewm_warehouseattributeitem (
	client_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code', 
	lidl_country 	VARCHAR(3) 		NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila', 
	source_system 	VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id			NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	lgnum			VARCHAR(5)		NOT NULL	COMMENT 'Warehouse Number/Warehouse Complex',
	matnr           VARCHAR(40)     NOT NULL    COMMENT 'Product',
	entitled        VARCHAR(10)     NULL        COMMENT 'Party Entitled to Dispose',
	umren           NUMBER(38,0)    NULL        COMMENT 'Denominator for conversion to base units of measure',
	mandt           VARCHAR(3)      NULL        COMMENT 'Client',
	matid           VARCHAR(22)     NULL        COMMENT 'Internal Number (UID) for Product',
	meinh           VARCHAR(3)      NOT NULL    COMMENT 'Alternative Unit of Measure',
	umrez           NUMBER(38,0)    NULL        COMMENT 'Numerator for Conversion to Base Units of Measure',
	basme           VARCHAR(3)      NULL        COMMENT 'Base Unit of Measure',
	ean11           VARCHAR(18)     NULL        COMMENT 'GTIN (EAN or UPC)',
	eancat          VARCHAR(2)      NULL        COMMENT 'Number Category of GTIN (EAN/UPC)',
	gtin_variant    VARCHAR(2)      NULL        COMMENT 'Variant for the Global Trade Item Number',
	brgew           NUMBER(38,3)    NULL        COMMENT 'Gross Weight',
	ntgew           NUMBER(38,3)    NULL        COMMENT 'Net weight',
	gewei           VARCHAR(3)      NULL        COMMENT 'Unit of Weight',
	volum           NUMBER(38,3)    NULL        COMMENT 'Volume',
	voleh           VARCHAR(3)      NULL        COMMENT 'Unit of Volume',
	capause         NUMBER(38,3)    NULL        COMMENT 'Capacity Consumption',
	laeng           NUMBER(38,3)    NULL        COMMENT 'Length',
	breit           NUMBER(38,3)    NULL        COMMENT 'Width',
	hoehe           NUMBER(38,3)    NULL        COMMENT 'Height',
	meabm           VARCHAR(3)      NULL        COMMENT 'Unit of Dimension for Length/Width/Height',
	maxstack        NUMBER(38,0)    NULL        COMMENT 'Maximum Stacking Factor',
	nest_ftr        NUMBER(38,0)    NULL        COMMENT 'Remaining Volume After Nesting (in Percent)',
	ty2tq           VARCHAR(1)      NULL        COMMENT 'Category of Unit of Measure',
	dwh_load_id    	NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    	TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    	TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 	DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   	DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     	BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, lgnum, matnr, meinh,dwh_valid_from)
) COMMENT = 'SAP EWM - Product Units of Measure Structure'
;