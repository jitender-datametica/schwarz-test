/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_zfm_registrations_tog_stage_1
Description		|	ZFM - stage table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_zfm_registrations_tog_stage_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(4) NOT NULL OPTIONS(description='Country_1 code.'),
registration_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description=''),
type_of_goods_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description=''),
description STRING(100) OPTIONS(description=''),
modified_tmsp DATETIME NOT NULL OPTIONS(description='')
) OPTIONS(description='ZFM - Registrations, TypesOfGoods subrecord');