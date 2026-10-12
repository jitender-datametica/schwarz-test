/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_wawistock_2
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE DATA.t_sapewm_wawistock_2 (
	client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code', 
	lidl_country 		VARCHAR(3) 		NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila', 
	source_system 		VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id				NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	lgnum				VARCHAR(5)		NOT NULL	COMMENT 'Warehouse Number/Warehouse Complex',
	entitled            VARCHAR(10)     NULL        COMMENT 'Party Entitled to Dispose',
	matnr               VARCHAR(40)     NOT NULL    COMMENT 'Product',
	charg               VARCHAR(10)     NULL        COMMENT 'Batch',
	batch               VARCHAR(50)     NULL        COMMENT 'Batch characteristic: External vendor batch',
	sub_art             VARCHAR(5)      NULL        COMMENT 'F&V Sub Article Number',
	qty                 NUMBER(38,14)   NULL        COMMENT 'Quantity Field',
	uom                 VARCHAR(3)      NULL        COMMENT 'Base Unit_2 of Measure',
	del_date            DATE            NULL        COMMENT 'Delivery Date (Planned)',
	pick_qty            NUMBER(38,14)   NULL        COMMENT 'Picking quantity',
	auom                VARCHAR(3)      NULL        COMMENT 'Alternative Unit_2 of Measure for Stockkeeping Unit_2',
	nfc_calc            BOOLEAN         NULL        COMMENT 'NFC: Calculation flag',
	nfc_calc_icon       VARCHAR(4)      NULL        COMMENT 'NFC: Calculation flag (icon)',
	nfc_ewmcalc         NUMBER(38,14)   NULL        COMMENT 'NFC: Calculated EWM',
	nfc_underdlv        NUMBER(38,14)   NULL        COMMENT 'NFC: Underdelivery',
	nfc_overdlv         NUMBER(38,14)   NULL        COMMENT 'NFC: Overdelivery',
	nfc_nonrecall       NUMBER(38,14)   NULL        COMMENT 'NFC: Non-Recall',
	nfc_zerodlv         NUMBER(38,14)   NULL        COMMENT 'NFC: Zero delivery',
	nfc_spsenhance      NUMBER(38,14)   NULL        COMMENT 'NFC: SPS Enhancement',
	nfc_spsreduct       NUMBER(38,14)   NULL        COMMENT 'NFC: SPS Reduction',
	dwh_load_id    		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 		DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   		DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     		BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, lgnum, matnr, dwh_valid_from)
) COMMENT = 'SAP EWM - Monitor node WaWi Stock/FVM Determination'
;