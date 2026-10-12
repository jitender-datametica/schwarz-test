/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_zfm_registrations_tog
Description		|	ZFM table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_zfm_registrations_tog (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(4) NOT NULL OPTIONS(description='Country code.'),
registration_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description=''),
type_of_goods_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description=''),
description STRING(100) OPTIONS(description=''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, registration_id, type_of_goods_id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='ZFM - Registrations, TypesOfGoods subrecord');