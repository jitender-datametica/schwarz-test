CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_write_off_event_type_1 (
write_off_event_type_id INTEGER NOT NULL
OPTIONS(description='The code identifying the type of write off event. (There are write offs for stores and write offs for warehouses.)'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
write_off_event_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the kind of write off events.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
correction_fg BOOL NOT NULL
OPTIONS(description='an indicator showing, if this write off event type defines a correction booking.'),
PRIMARY KEY (write_off_event_type_id, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the types of write off events. There are write offs for stores and write offs for warehouses.');