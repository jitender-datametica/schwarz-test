DROP TABLE IF EXISTS ugs_aris_production_core.t_fact_int_process_target_1;
CREATE OR REPLACE TABLE ugs_aris_production_core.t_fact_int_process_target_1 (
dwh_tenant_cd STRING(8) NOT NULL OPTIONS(description='The code for the data warehoue tenant.'),
process_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the process model.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_1 organization to which the process model shall be rolled out.'),
dwh_valid_fg BOOL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(100)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.')
) CLUSTER BY dwh_tenant_cd
OPTIONS(description='This bridge table shows which international processes are targeted for a country.');