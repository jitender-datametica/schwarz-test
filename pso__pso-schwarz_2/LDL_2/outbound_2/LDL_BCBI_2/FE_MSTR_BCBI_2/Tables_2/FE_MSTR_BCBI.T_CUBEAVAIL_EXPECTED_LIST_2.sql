CREATE TABLE IF NOT EXISTS ldl_bcbi_fe_mstr_bcbi.t_cubeavail_expected_list_2 (
zone STRING(2),
project_id INTEGER,
project_name STRING(255),
cube_id INTEGER,
cube_name STRING(255),
subcube_id INTEGER,
subcube_name STRING(255),
dat_rec_start DATE,
dat_rec_end DATE,
sla_vta STRING(16777216),
sla_vvta STRING(16777216),
sla_nvta STRING(16777216),
last_update DATE,
timestamp_load_bcbi TIMESTAMP
);