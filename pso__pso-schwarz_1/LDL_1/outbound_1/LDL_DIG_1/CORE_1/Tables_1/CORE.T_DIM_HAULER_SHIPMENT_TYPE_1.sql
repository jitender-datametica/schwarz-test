/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_HAULER_SHIPMENT_TYPE_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 27. Juni 2023 09:42:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_hauler_shipment_type_1 (
hauler_ship_type_id STRING(50) NOT NULL
OPTIONS(description='The unique identifier for available shipment modes for carrier that is coming from source system'),
hauler_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for hauler'),
hauler_name STRING(100) OPTIONS(description='The name by which the hauler is known'),
hauler_country_cd STRING(5)
OPTIONS(description='The unique code for a country_1 according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
hauler_ship_type_desc STRING(250) OPTIONS(description='A textual description for the carrirer shipment mode.'),
pack_size_handle_group_cd STRING(5)
OPTIONS(description='A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it -\' 1 person\'  ,\'2 persons\' etc'),
delivery_type_name STRING(100) OPTIONS(description='A textual description for the package_1 delivery type  '),
pack_return_type_name STRING(100)
OPTIONS(description='A textual description for the package_1 return type  (label , pick_up )'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (hauler_ship_type_id) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the available shipment modes for carrier');