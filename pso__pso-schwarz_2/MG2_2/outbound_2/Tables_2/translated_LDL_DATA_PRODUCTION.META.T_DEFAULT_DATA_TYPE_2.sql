CREATE OR REPLACE TABLE ldl_data_production_meta.t_default_data_type_2 (
domain_name STRING(100) NOT NULL OPTIONS(description='The name of the domain.'),
technology_name STRING(100) NOT NULL
OPTIONS(description='The name by which the technology is known, e.g. Teradata, AVRO, etc.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
data_type_name STRING(100) NOT NULL
OPTIONS(description='The name for the data type, as defined for the given technology.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (technology_name, domain_name, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='In a physical model a domain is implemented by a data type. Depending on the technology, the domain concept defines a default data type for each domain. (Note that this data type may be overwritten for a particular column.)');