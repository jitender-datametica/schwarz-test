/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_alma_lanes_1
Description		|	ALMA table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_alma_lanes_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='wh_nr as a digit Source warehouse number (datastore_data:lagernummer)'),
lane_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Primary Key'),
gate_id BIGNUMERIC(38,0) OPTIONS(description='Gate ID from T1214_GATES_1'),
label STRING(200) OPTIONS(description='Label of the lane visible in the application.'),
allocation_state_id BIGNUMERIC(38,0) OPTIONS(description='Status_1 ID from T1211_ALLOCATIONSTATES'),
update_user STRING(50)
OPTIONS(description='The user who changed the record last.\"ALMA\" after initial master data load.'),
update_tmsp DATETIME OPTIONS(description='Timestamp of the import for last change.'),
next_lane_id STRING(200)
OPTIONS(description='ID of the next displayed lane according to the current lane ordering. NULL if the record represents the gate\'s last lane.'),
info STRING(500) OPTIONS(description='Lane comment.'),
gr_capacity BIGNUMERIC(38,0) OPTIONS(description='Lane capacity used for all GR processes (Gate Calculation)'),
gi_capacity BIGNUMERIC(38,0) OPTIONS(description='Lane capacity used for all GI processes'),
laneuu_id STRING(50) OPTIONS(description='Default SYS_GUID() - Used by the ALMA webservice'),
tour_id BIGNUMERIC(38,0) OPTIONS(description='ID of the last TPP tour_1 that blocked this lane.'),
blocked_by_tour BIGNUMERIC(38,0) OPTIONS(description='Whether the lane is currently blocked by the GI process.'),
next_lane STRING(50) OPTIONS(description='Gives the order of the Lane'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, lane_id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='ALMA - The table contains all lane definition data (warehouse modelling master data).');