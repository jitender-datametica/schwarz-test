/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SUBSCRIBER_REG_EVENT_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 8. September 2022 14:54:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_subscriber_reg_event_1 (
subscr_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the subscriber'),
country_cd STRING(5) NOT NULL OPTIONS(description='The unique country_1 code'),
event_id STRING(100) NOT NULL OPTIONS(description='The identifier of an event'),
event_type STRING(100) NOT NULL OPTIONS(description='Type of the event, e.g deletion'),
event_dt DATE OPTIONS(description='The date of the event from SFMC source'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (subscr_sid, country_cd, event_id, event_type) NOT ENFORCED
)
OPTIONS(description='ETL table to support the t_dim_subscriber_reg_1 validity_1 by tracking the event type from SFMC source ');