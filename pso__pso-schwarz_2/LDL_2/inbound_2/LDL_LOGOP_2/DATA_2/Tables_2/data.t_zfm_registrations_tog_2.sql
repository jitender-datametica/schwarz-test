/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_zfm_registrations_tog_2
Description		|	ZFM table
====================================================================================================
*/

CREATE TABLE DATA.t_zfm_registrations_tog_2 (
client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code',
lidl_country 		VARCHAR(4) 		NOT NULL 	COMMENT 'Country_2 code.',
registration_id		NUMBER(38,0)    NOT NULL 	COMMENT '',
type_of_goods_id	NUMBER(38,0)    NOT NULL 	COMMENT '',
description			VARCHAR(100)    NULL 	 	COMMENT '',
dwh_load_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created 		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated 		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 		DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to 		DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg 			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id, registration_id, type_of_goods_id, dwh_valid_from)
) COMMENT = 'ZFM - Registrations, TypesOfGoods subrecord'
; 