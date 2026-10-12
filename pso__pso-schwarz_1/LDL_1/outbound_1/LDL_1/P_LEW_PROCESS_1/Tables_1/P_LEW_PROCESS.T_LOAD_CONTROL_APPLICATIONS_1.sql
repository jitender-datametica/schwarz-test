CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_load_control_applications_1 (
load_process_application_id BIGNUMERIC(38,0) NOT NULL,
load_process_application_name STRING(250) COLLATE 'und:ci' NOT NULL,
load_process_application_desc STRING(250) COLLATE 'und:ci' NOT NULL
);