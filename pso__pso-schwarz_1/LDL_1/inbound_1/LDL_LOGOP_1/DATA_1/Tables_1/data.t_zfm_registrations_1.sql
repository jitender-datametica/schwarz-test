/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_zfm_registrations_1
Description		|	ZFM table
====================================================================================================
*/

CREATE TABLE DATA.t_zfm_registrations_1 (
client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code',
lidl_country 		VARCHAR(4) 		NOT NULL 	COMMENT 'Country_1 code.',
registration_id		NUMBER(38,0)    NOT NULL 	COMMENT '',
WAREHOUSE			VARCHAR(450)	NULL 	 	COMMENT '',
country_1             VARCHAR(100)    NULL 	 	COMMENT '',
created             TIMESTAMP       NULL 	 	COMMENT '',
supplier_name       VARCHAR(100)    NULL 	 	COMMENT '',
carrier_name        VARCHAR(100)    NULL 	 	COMMENT '',
pallet_count_ep     NUMBER(38,0)    NULL 	 	COMMENT '',
pallet_count_dd     NUMBER(38,0)    NULL 	 	COMMENT '',
pallet_count_ip     NUMBER(38,0)    NULL 	 	COMMENT '',
reference_number    VARCHAR(100)    NULL 	 	COMMENT '',
book_date           TIMESTAMP       NULL 	 	COMMENT '',
pager_number        VARCHAR(50)     NULL 	 	COMMENT '',
full_name           VARCHAR(100)    NULL 	 	COMMENT '',
license_plate       VARCHAR(20)     NULL 	 	COMMENT '',
registration_state  VARCHAR(50)     NULL 	 	COMMENT '',
confirmed           BOOLEAN         NULL 	 	COMMENT '',
canceled            BOOLEAN         NULL 	 	COMMENT '',
warehouse_id		NUMBER(38,0)    NULL 	 	COMMENT '',
country_id			NUMBER(38,0)    NULL 	 	COMMENT '',
dwh_load_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created 		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated 		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 		DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to 		DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg 			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id, registration_id, dwh_valid_from)
) COMMENT = 'ZFM - Registrations'
; 