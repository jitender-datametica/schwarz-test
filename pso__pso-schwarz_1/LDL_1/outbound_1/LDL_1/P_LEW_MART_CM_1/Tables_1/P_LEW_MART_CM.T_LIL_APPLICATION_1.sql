CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cm.t_lil_application_1 (
application_id BIGNUMERIC(38,0) NOT NULL,
application_desc STRING(50) NOT NULL,
application_desc_en STRING(50) NOT NULL,
PRIMARY KEY (application_id) NOT ENFORCED
) OPTIONS(description='THE DIMENSIONAL TABLE FOR THE APPLICATION ATTRIBUTE');