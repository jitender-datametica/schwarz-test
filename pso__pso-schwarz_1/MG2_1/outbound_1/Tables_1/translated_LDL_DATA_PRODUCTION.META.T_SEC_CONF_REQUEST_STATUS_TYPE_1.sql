CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_conf_request_status_type_1 (
request_status_cd STRING(20) NOT NULL
OPTIONS(description='The status_1 of a grant status_1 if it is approved, requested or denied.'),
request_status_descr STRING(250) NOT NULL OPTIONS(description='The description of request status_1'),
PRIMARY KEY (request_status_cd) NOT ENFORCED
) OPTIONS(description='The entity definies the lifecycle of the granting an object to an user group.');