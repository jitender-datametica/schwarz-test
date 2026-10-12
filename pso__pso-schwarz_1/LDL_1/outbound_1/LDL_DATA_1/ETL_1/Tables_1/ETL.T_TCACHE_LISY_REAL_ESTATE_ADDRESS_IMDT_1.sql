CREATE TABLE IF NOT EXISTS ldl_data_etl.t_tcache_lisy_real_estate_address_imdt_1 (
real_estate_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
addr_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the address_1 of the real estate object. This may be a street address_1, a phone number or an email address.'),
tel_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the address_1 of the real estate object. This may be a street address_1, a phone number or an email address.'),
src_sinkmodifiedon DATETIME,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);