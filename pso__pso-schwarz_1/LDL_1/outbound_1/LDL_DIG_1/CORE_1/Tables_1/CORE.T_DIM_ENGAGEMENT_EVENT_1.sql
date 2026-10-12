CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_engagement_event_1 (
engagement_event_cd STRING(5) NOT NULL OPTIONS(description='The unique code for the event type (e.g. s-send, b-bounce)'),
engagement_event_name STRING(100) NOT NULL
OPTIONS(description='The name of the engagement events (e.g. send, open, click)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (engagement_event_cd) NOT ENFORCED
) OPTIONS(description='The dimension holds the different engagement event type (e.g. send, open, click)');