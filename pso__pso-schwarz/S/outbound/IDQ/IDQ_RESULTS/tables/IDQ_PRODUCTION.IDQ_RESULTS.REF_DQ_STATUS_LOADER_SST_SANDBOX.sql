CREATE OR REPLACE TABLE idq_production_idq_results.ref_dq_status_loader_sst_sandbox (
id BIGNUMERIC(38,0) NOT NULL,
source_system_type_id BIGNUMERIC(38,0) NOT NULL,
loader_sandbox_name STRING(400),
is_infor_name STRING(400)
);