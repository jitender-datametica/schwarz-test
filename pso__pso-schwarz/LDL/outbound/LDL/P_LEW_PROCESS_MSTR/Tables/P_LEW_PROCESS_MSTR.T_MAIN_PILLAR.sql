CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_main_pillar (
main_pillar_id BIGNUMERIC(38,0) NOT NULL,
main_pillar_name STRING(20) COLLATE 'und:ci' NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);