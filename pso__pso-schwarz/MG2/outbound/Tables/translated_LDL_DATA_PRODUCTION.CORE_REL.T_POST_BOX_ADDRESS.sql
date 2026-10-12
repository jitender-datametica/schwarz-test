CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_post_box_address (
po_box_addr_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the post office box address.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
country_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the country.'),
iso_country_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the country according to ISO 3166.'),
postal_cd_area_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the postal code area, in which the post office box is located.'),
zip STRING(15) NOT NULL
OPTIONS(description='A code used by the postal service to identify a geographical area. E.g. 74072 for Heilbronn in Germany'),
po_box_nr STRING(20) NOT NULL
OPTIONS(description='The number of a post office box, i.e. of a place managed by a post office where mail can be collected.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (po_box_addr_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='A post office box is a place managed by a post office where mail can be collected.');