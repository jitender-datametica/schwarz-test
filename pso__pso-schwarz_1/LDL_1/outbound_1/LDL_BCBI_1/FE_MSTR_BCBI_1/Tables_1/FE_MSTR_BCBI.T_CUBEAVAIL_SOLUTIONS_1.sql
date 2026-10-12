CREATE TABLE IF NOT EXISTS ldl_bcbi_fe_mstr_bcbi.t_cubeavail_solutions_1 (
subcube_id BIGNUMERIC(38,0),
subcube_name STRING(16777216),
first_resp_solution_id BIGNUMERIC(38,0),
first_resp_solution_name STRING(16777216),
sec_resp_solution_id BIGNUMERIC(38,0),
sec_resp_solution_name STRING(16777216),
last_update DATE,
timestamp_load_bcbi TIMESTAMP
);