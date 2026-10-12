/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_stagingdimacell_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_stagingdimacell_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
src_tgt_dist BIGNUMERIC(38,10) OPTIONS(description='Distance from origin to destination address_2 (disregard UOM)'),
src_tgt_dur BIGNUMERIC(38,0) OPTIONS(description='Duration from origin to destionation address_2 (In Minutes) - Imported'),
src_address_id STRING(512) NOT NULL OPTIONS(description='Identifier of the origin address_2'),
resource_type_id STRING(512) NOT NULL OPTIONS(description='The identifier for resource type'),
time_profile_id STRING(512) NOT NULL OPTIONS(description='Identifier of time profile'),
tgt_address_id STRING(512) NOT NULL OPTIONS(description='Identifier of the destination address_2'),
toll_dist2 BIGNUMERIC(38,10) OPTIONS(description='Distance for which the second type of toll is considered'),
toll_dist BIGNUMERIC(38,10) OPTIONS(description='Distance for which first type of toll is considered'),
tolldistance3 BIGNUMERIC(38,10)
OPTIONS(description='Distance for which the third type of toll is considered, in kilometers'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, src_address_id, tgt_address_id, resource_type_id, time_profile_id, dwh_valid_from)
NOT ENFORCED
) OPTIONS(description='Object type in quintiq is StagingDiMaCell');