CREATE TABLE IF NOT EXISTS ldl_score_meta.t_event_key_type_2 (
event_key_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the EVENT.'),
event_key_type_name STRING(100) NOT NULL
OPTIONS(description='The name of the type of natural key which identifies the EVENT.'),
event_key_type_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the type of natural key, detailing its format and the meaning of the components.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (event_key_type_cd) NOT ENFORCED
) OPTIONS(description='This minor entity defines the type of natural key which identifies a EVENT.');