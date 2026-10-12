CREATE OR REPLACE TABLE ldl_data_production_meta.t_dim_table_2 (
table_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the table.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
sys_name STRING(100) NOT NULL OPTIONS(description='The name of the IT system.'),
db_name STRING(100) NOT NULL OPTIONS(description='The name by which the database is identified on the system.'),
schema_name STRING(100) NOT NULL
OPTIONS(description='The name of the schema, as it is defined in the database management system.'),
table_name STRING(250) NOT NULL OPTIONS(description='The physical table name.'),
table_comment_txt STRING(1000) OPTIONS(description='The comment text for the table.'),
tenant_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the tenant, i.e. the organizational unit_2 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.'),
tenant_name STRING(100) NOT NULL
OPTIONS(description='The name of the tenant, i.e. the organizational unit_2 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.'),
technology_name STRING(100) OPTIONS(description='The name by which the technology is known, e.g. Teradata, AVRO, etc.'),
env_cd STRING(20) NOT NULL
OPTIONS(description='The code which identifies the (development / test_2 / production / ...) environment.'),
env_name STRING(100) NOT NULL
OPTIONS(description='The name of the i(development / test_2 / production / ...) environment.'),
table_status_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the lifecycle status_2 of a table, i.e. deployed or dropped.'),
table_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status_2 of a table.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (table_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='The table dimension contains all tables which are subject to a data quality check. (If a check accesses a view, it is linked to the underlying table.)');