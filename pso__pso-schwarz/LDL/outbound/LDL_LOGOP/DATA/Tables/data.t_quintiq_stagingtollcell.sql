/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_stagingtollcell
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_stagingtollcell (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
src_address_id STRING(512) NOT NULL OPTIONS(description='Identifier of the origin address'),
new_mod_fg BOOL OPTIONS(description='Indicator whether it\"s newly imported/created or it has fields updated'),
soft_dlv_fg BOOL OPTIONS(description='True if the instance is removed from external system\"'),
time_profile_id STRING(512) NOT NULL OPTIONS(description='Identifier of time profile'),
tgt_address_id STRING(512) NOT NULL OPTIONS(description='Identifier of the destination address'),
toll_cat_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The identifier for toll category'),
toll_cost BIGNUMERIC(38,10) OPTIONS(description='The toll cost from origin to destination address'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, src_address_id, tgt_address_id, toll_cat_id, time_profile_id, dwh_valid_from)
NOT ENFORCED
) OPTIONS(description='QUINTIQ - Object type in quintiq is StagingTollCell');