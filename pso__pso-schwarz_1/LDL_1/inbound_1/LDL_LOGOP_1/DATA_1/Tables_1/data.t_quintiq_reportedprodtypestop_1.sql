/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedprodtypestop_1
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_reportedprodtypestop_1 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_1 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_1 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_id VARCHAR(5) NOT NULL COMMENT 'Warehouse ID',
	address_id VARCHAR(512) NOT NULL COMMENT 'ID of the address_1 of the stop state',
	delivery_dt DATE NOT NULL COMMENT 'Delivery date of the dataset',
	temp_fg BOOLEAN COMMENT 'Indicates if this is a temporary reported product type stop',
	product_type_id VARCHAR(512) NOT NULL COMMENT 'ID of the product type',
	stop_state_qty NUMBER(38,10) COMMENT 'Quantity 1 of the product type stop state',
	start_tmsp TIMESTAMP_NTZ(9) COMMENT 'Start time of the stop state',
	stop_state_type VARCHAR(512) COMMENT 'Type of the stop state',
	addresscomment VARCHAR(512) COMMENT 'Comment for the Address.',
	addressiddelivery VARCHAR(512) COMMENT 'Delivery addresses ID for the stop',
	addressidpickup VARCHAR(512) COMMENT 'Pickup Addresses ID for the Stop.',
	reportedtourgid VARCHAR(512) NOT NULL COMMENT 'GID of the reported tour_1',
	reportedtourid VARCHAR(512) COMMENT 'ID of the reported tour_1',
	transfercomment VARCHAR(512) COMMENT 'Comment for the Stock Transfer.',
	transferreason VARCHAR(512) COMMENT 'Reason for the Stock Transfer',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	dwh_valid_from DATE NOT NULL COMMENT 'Valid from date',
	dwh_valid_to DATE NOT NULL COMMENT 'Valid to date',
	deleted_fg BOOLEAN NOT NULL COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, address_id, product_type_id, reportedtourgid, delivery_dt, dwh_valid_from)
	)
COMMENT = 'QUINTIQ - Object type in quintiq is reported product type stop'
;
