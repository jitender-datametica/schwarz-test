CREATE OR REPLACE TABLE ldl_data_production_meta.t_data_quality_dimension (
dq_dimension_cd STRING(20) NOT NULL
OPTIONS(description='A code identifying the basic aspect by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.'),
dq_dimension_name STRING(100) NOT NULL
OPTIONS(description='The name of the basic aspect by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.'),
dq_dimension_descr STRING(250) NOT NULL OPTIONS(description='The definition of the data quality dimension.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (dq_dimension_cd) NOT ENFORCED
)
OPTIONS(description='A data quality dimension describes the basic aspects by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.');