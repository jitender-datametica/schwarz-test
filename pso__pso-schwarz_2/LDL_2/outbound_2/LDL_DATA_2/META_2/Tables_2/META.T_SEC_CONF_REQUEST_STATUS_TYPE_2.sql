CREATE TABLE IF NOT EXISTS ldl_data_meta.t_sec_conf_request_status_type_2 (
request_status_cd STRING(20) NOT NULL
OPTIONS(description='The status_2 of a grant status_2 if it is approved, requested or denied.'),
request_status_descr STRING(250) NOT NULL OPTIONS(description='The description of request status_2'),
PRIMARY KEY (request_status_cd) NOT ENFORCED
) OPTIONS(description='The entity definies the lifecycle of the granting an object to an user group.');