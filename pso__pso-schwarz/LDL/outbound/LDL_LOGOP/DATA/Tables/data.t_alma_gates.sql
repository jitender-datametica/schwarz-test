/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_alma_gates
Description		|	ALMA table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_alma_gates (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='wh_nr as a digit Source warehouse number (datastore_data:lagernummer)'),
gate_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Primary Key'),
gateuu_id STRING(50) OPTIONS(description='Default SYS_GUID. Used by the ALMA webservice'),
label STRING(200) OPTIONS(description='Label of the gate'),
allocation_state_id BIGNUMERIC(38,0) OPTIONS(description='Status ID from T1211_ALLOCATIONSTATES'),
task_id BIGNUMERIC(38,0) OPTIONS(description='eGIN task ID if the gate has been blocked during gate calculation.'),
tour_id BIGNUMERIC(38,0) OPTIONS(description='TPP tour ID if the gate has been blocked automatically by tour status.'),
blocked_by_tour BIGNUMERIC(38,0)
OPTIONS(description='Manually unblocking an automatic tour block sets this field to 0 effectively releasing the gate block. Prevents the same tour from re-blocking.'),
info STRING(200) OPTIONS(description='Comment that is displayed in the application with the gate block.'),
update_user STRING(50) OPTIONS(description='Username of the user who changed the gate status last.'),
update_tmsp DATETIME OPTIONS(description='Time of the last status change.'),
temperature_id BIGNUMERIC(38,0) OPTIONS(description='Was required for the WAMAS Areas'),
next_gate STRING(50) OPTIONS(description='Gives the order of the Gates'),
gi_overlapping BIGNUMERIC(38,0)
OPTIONS(description='Decides the direction an overlapping assignment is possible. By default the value is 0.'),
gr_overlapping BIGNUMERIC(38,0)
OPTIONS(description='Decides the direction an overlapping assignment is possible. By default the value is 0.'),
area_id BIGNUMERIC(38,0) OPTIONS(description='Refers to the Table T1240_AREAS'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, gate_id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='ALMA - The table contains basic gate definition data (warehouse modelling master data)');