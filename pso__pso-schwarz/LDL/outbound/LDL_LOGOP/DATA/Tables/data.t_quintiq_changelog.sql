/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_changelog
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_changelog (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
changed_attr STRING(512) OPTIONS(description='The attribute that was changed'),
change_tmsp DATETIME NOT NULL OPTIONS(description='Time when the ok button was pressed to trigger the change'),
new_val STRING(512) OPTIONS(description='The new value of the attribute'),
old_val STRING(512) OPTIONS(description='The old value of the attribute'),
change_reason STRING(512) OPTIONS(description='Reason for the change'),
route_gid STRING(512) OPTIONS(description='GID of the route this change corresponds to'),
tour_gid STRING(512) NOT NULL OPTIONS(description='GID of the tour corrosponding to this change'),
user_nr STRING(512) OPTIONS(description='Employee number of the user that made the change'),
haschangeswhilestatusclosed BOOL OPTIONS(description='True if status closed is all other statuses false'),
changedobject STRING(512) OPTIONS(description='The name of the object that was changed'),
changedobjectid STRING(512) OPTIONS(description='The ID of the object that has been changed'),
datasetname STRING(512) OPTIONS(description='The name of the dataset where this change occured'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, tour_gid, change_tmsp, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='Object type in quintiq is ChangeLog Object tracking user entered changes to specific attributes');