CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_address_demographics_1 (
addr_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the postal address.'),
demographics_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the type of statistical information.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
demographic_meas NUMERIC(29,5) NOT NULL
OPTIONS(description='The value of the statistical information which has been collected for this address.'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit_1 of measure.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (demographics_type_cd, addr_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Several statistical informations can be collected on an address_1, such as the number of inhabitants in its vicinity. The type of information is defined by the demographic type');