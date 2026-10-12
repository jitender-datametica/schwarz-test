CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_pillar_1 (
pillar_id BIGNUMERIC(38,0) NOT NULL,
main_pillar_id BIGNUMERIC(38,0) NOT NULL,
pillar_name STRING(100) COLLATE 'und:ci' NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);