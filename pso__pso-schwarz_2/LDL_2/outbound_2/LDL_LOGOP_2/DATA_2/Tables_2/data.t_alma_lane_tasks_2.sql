/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_alma_lane_tasks_2
Description		|	ALMA table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_alma_lane_tasks_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='wh_nr as a digit Source warehouse number (datastore_data:lagernummer)'),
lane_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID of the lane'),
task_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='eGIN task ID'),
gr_allocation BIGNUMERIC(38,0) OPTIONS(description='Default 0. Type of eGIN Task Assignment.'),
update_tmsp DATETIME OPTIONS(description='Shows the Timestamp'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, lane_id, task_id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='ALMA - This table saves all eGIN tasks assigned to lanes for the GR process.');