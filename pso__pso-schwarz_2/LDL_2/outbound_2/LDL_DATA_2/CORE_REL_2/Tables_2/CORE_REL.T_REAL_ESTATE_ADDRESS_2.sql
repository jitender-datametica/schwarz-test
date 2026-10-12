CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_real_estate_address_2 (
real_estate_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
addr_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the address_2 of the real estate object. This may be a street address_2, a phone number or an email address.'),
addr_usg_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the way how an address_2 is used. E.g. an address_2 may be used for the customer entrance for a store, and another one for the deliveries.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
addr_type_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the discriminator for addresses.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (addr_usg_type_cd, addr_sid, real_estate_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This entity stores the address_2(es) of a real estate object. An object might have more than one address_2, e.g. an official address_2, the customer entrance and the delivery entrance. The type of address_2 is defined by the address_2 usage type.');