CREATE OR REPLACE TABLE ldl_data_production_meta.t_reject_log_2 (
load_id INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the execution of an ETL job.'),
rejected_rec_txt STRING(1000) NOT NULL
OPTIONS(description='The record which has been rejected, as an unformatted text string.'),
reject_reason_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the reason, why an ETL job has excluded a record from further processing.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (load_id, rejected_rec_txt) NOT ENFORCED
)
OPTIONS(description='A log table containing all records which had to be excluded from further processing. Records can be rejected because of the following reasons: The record cannot be read, the record structure is invalid or the key of the records cannot be interpreted.');