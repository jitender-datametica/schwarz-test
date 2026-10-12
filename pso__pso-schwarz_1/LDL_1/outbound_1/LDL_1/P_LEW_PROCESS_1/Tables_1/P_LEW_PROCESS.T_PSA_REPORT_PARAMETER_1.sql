CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_psa_report_parameter_1 (
env_cd STRING(1) COLLATE 'und:ci' DEFAULT 'Z' NOT NULL,
report_id BIGNUMERIC(38,0) NOT NULL,
withdrawal DATE NOT NULL,
report_from DATE NOT NULL,
report_until DATE NOT NULL
);