/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_zfm_registrations_tog_stage
Description		|	ZFM - stage table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_zfm_registrations_tog_stage (
client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code',
lidl_country 		VARCHAR(4) 		NOT NULL 	COMMENT 'Country code.',
registration_id		NUMBER(38,0)    NOT NULL 	COMMENT '',
type_of_goods_id	NUMBER(38,0)    NOT NULL 	COMMENT '',
description			VARCHAR(100)    NULL 	 	COMMENT '',
modified_tmsp       TIMESTAMP       NOT NULL 	COMMENT ''
) COMMENT = 'ZFM - Registrations, TypesOfGoods subrecord'
; 