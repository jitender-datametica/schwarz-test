/* --------------------------------------------------------------------------------
   DDL for table: t_write_off_event_type_2
   generated from Powerdesigner on Dienstag, 22. Oktober 2024 13:38:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_write_off_event_type_2 (
write_off_event_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The code identifying the type of write off event. (There are write offs for stores and write offs for warehouses.)'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
write_off_event_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the kind of write off events.'),
correction_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this write off event type defines a correction booking.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (write_off_event_type_id, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the types of write off events. There are write offs for stores and write offs for warehouses.');