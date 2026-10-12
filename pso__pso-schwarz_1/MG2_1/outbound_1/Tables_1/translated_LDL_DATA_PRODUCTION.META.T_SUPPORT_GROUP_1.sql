CREATE OR REPLACE TABLE ldl_data_production_meta.t_support_group_1 (
support_grp_cd STRING(20) NOT NULL OPTIONS(description='The code which identifies the support group.'),
support_grp_name STRING(100) NOT NULL OPTIONS(description='The name for the support group.'),
solution_cd STRING(20) NOT NULL OPTIONS(description='The code which identifies the solution.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (support_grp_cd) NOT ENFORCED
) OPTIONS(description='A support group is responsible for resolving a data quality issue');