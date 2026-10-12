CREATE OR REPLACE TABLE ldl_data_production_meta.t_tenant_2 (
tenant_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the tenant, i.e. the organizational unit_2 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.'),
tenant_name STRING(100) NOT NULL
OPTIONS(description='The name of the tenant, i.e. the organizational unit_2 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (tenant_cd) NOT ENFORCED
)
OPTIONS(description='The tenant describes an organizational unit_2 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.');