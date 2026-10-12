CREATE OR REPLACE TABLE ldl_data_production_meta.t_scheduled_etl_job_1 (
etl_job_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the ETL job'),
scheduling_unit_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the group of ETL jobs that are always executed together.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (scheduling_unit_sid, etl_job_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='An ETL job may be part of a scheduling unit.');