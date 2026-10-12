CREATE TABLE IF NOT EXISTS ldl_bcbi_fe_mstr_bcbi.t_cubeavail_update (
day DATE,
zone STRING(2),
amount_cube_vta INTEGER,
amount_cube_vvta INTEGER,
amount_cube_nvta INTEGER,
endtime STRING(255),
cubing_status STRING(255),
cube_restarted STRING(255),
last_update DATE,
timestamp_load_bcbi DATETIME
);