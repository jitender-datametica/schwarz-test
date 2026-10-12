/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_zfm_registrations_stage_2
Description		|	ZFM - stage table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_zfm_registrations_stage_2 (
client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code',
lidl_country 		VARCHAR(4) 		NOT NULL 	COMMENT 'Country_2 code.',
registration_id		NUMBER(38,0)    NOT NULL 	COMMENT '',
WAREHOUSE			VARCHAR(450)	NULL 	 	COMMENT '',
country_2             VARCHAR(100)    NULL 	 	COMMENT '',
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
modified_tmsp       TIMESTAMP       NOT NULL 	COMMENT ''
) COMMENT = 'ZFM - Registrations'
; 