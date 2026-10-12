CREATE OR REPLACE TABLE ldl_data_production_meta.t_data_quality_project_1 (
dq_project_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the data quality project.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dq_project_name STRING(100) NOT NULL OPTIONS(description='The name by which the data quality project is known.'),
tenant_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the tenant, i.e. the organizational unit_1 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (dq_project_cd, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A data quality project is an initiative to improve the quality of certain data areas. A data quality project is specific to a tenant.');