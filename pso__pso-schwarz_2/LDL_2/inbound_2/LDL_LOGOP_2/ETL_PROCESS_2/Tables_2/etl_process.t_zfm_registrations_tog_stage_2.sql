/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_zfm_registrations_tog_stage_2
Description		|	ZFM - stage table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_zfm_registrations_tog_stage_2 (
client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code',
lidl_country 		VARCHAR(4) 		NOT NULL 	COMMENT 'Country_2 code.',
registration_id		NUMBER(38,0)    NOT NULL 	COMMENT '',
type_of_goods_id	NUMBER(38,0)    NOT NULL 	COMMENT '',
description			VARCHAR(100)    NULL 	 	COMMENT '',
modified_tmsp       TIMESTAMP       NOT NULL 	COMMENT ''
) COMMENT = 'ZFM - Registrations, TypesOfGoods subrecord'
; 