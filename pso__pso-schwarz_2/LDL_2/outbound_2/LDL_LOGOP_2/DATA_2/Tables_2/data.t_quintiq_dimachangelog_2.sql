/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_dimachangelog_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_dimachangelog_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
changed_attr STRING(512) NOT NULL OPTIONS(description='The attribute that was changed'),
change_tmsp DATETIME OPTIONS(description='Time when the ok button was pressed to trigger the change'),
change_id STRING(512) NOT NULL OPTIONS(description='Combination of AddressFrom, To, ResourceType and timeProfile'),
new_val STRING(512) OPTIONS(description='The new value of the attribute'),
old_val STRING(512) OPTIONS(description='The old value of the attribute'),
user_nr STRING(512) OPTIONS(description='Employee_2 number of the user that made the change'),
changedobject STRING(512)
OPTIONS(description='The name of the object that was changed (StagingDiMaCell or StagingTollCell)'),
datasetname STRING(512) OPTIONS(description='The name of the dataset where this change occured'),
reason STRING(512) OPTIONS(description='The given reason for this DiMa change'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, change_id, changed_attr, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='Object type in quintiq is DiMaChangeLog Object tracking user entered changes to specific attributes');