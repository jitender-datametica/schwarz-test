/* --------------------------------------------------------------------------------
   DDL for table: t_employee_time_tracking_status_type
   generated from Powerdesigner on Dienstag, 29. Oktober 2024 11:15:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_employee_time_tracking_status_type (
emp_tm_tracking_status_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the lifecycle status for employee time tracking records. A record may be active or cancelled.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
emp_tm_tracking_status_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status for employee time tracking records. A record may be active or cancelled.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (emp_tm_tracking_status_type_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the lifecycle status of employee time tracking records. A record may be active or cancelled.');