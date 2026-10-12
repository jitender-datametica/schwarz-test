CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_travel_booking_room_type (
trav_booking_room_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code for the room type'),
trav_booking_room_type_descr STRING(250) OPTIONS(description='A textual description for room type'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
trav_booking_room_type_group_cd STRING(50)
OPTIONS(description='The code for the grouping of room type (Double, Single)'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (trav_booking_room_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the room type codes(DB H, APX1). Because of different sources may be different from the one in travel offer');