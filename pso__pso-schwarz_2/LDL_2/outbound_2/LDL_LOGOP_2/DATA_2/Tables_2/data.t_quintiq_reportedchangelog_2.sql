/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedchangelog_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_reportedchangelog_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
changed_attr STRING(512) NOT NULL OPTIONS(description='attribute which has been changed'),
change_tmsp DATETIME NOT NULL OPTIONS(description='date and time user have made change'),
delivery_dt DATE OPTIONS(description='End of the delivery day to optimize for (max 24hrs after start).'),
new_val STRING(512) OPTIONS(description='new value of attribute'),
old_val STRING(512) OPTIONS(description='old value of attribute'),
change_reason STRING(512) OPTIONS(description='reason to change the value'),
route_gid STRING(512)
OPTIONS(description='GID is to have a unique identifier of a Route across different delivery days for the same RDC.'),
tour_gid STRING(512) NOT NULL
OPTIONS(description='GID is to have a unique identifier of a tour_2 across different delivery days for the same RDC.'),
user_name STRING(512) OPTIONS(description='user name'),
haschangeswhilestatusclosed BOOL OPTIONS(description='True if status_2 closed is all other statuses false'),
changedobject STRING(512) OPTIONS(description='The name of the object that was changed'),
changedobjectid STRING(512) OPTIONS(description='The ID of the object that has been changed'),
hauliername STRING(512) OPTIONS(description='The name of the haulier, which is set when a tour_2 was changed'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, tour_gid, change_tmsp, changed_attr, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='The object ReportedChangeLog in the RDCMatrix dataset gathers all relevant data for this object from the ChangeLog objects in the RDCDay dataset.');