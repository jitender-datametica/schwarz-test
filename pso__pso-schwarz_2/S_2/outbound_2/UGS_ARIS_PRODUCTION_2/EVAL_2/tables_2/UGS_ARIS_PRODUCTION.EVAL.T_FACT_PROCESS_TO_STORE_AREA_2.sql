DROP TABLE IF EXISTS ugs_aris_production_eval.t_fact_process_to_store_area_2;
CREATE OR REPLACE TABLE ugs_aris_production_eval.t_fact_process_to_store_area_2 (
dwh_tenant_cd STRING(8) NOT NULL OPTIONS(description='The code for the data warehoue tenant.'),
process_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the process model.'),
store_area_cd STRING(20) NOT NULL
OPTIONS(description='The code for an area in a store, such as fresh food, meat, non-food or the cash register area.'),
dwh_valid_fg BOOL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(100)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.')
) CLUSTER BY dwh_tenant_cd;