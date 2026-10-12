CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_internal_organization_real_estate_1 (
int_org_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
int_org_real_estate_usg_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how an internal organization may use a real estate object.'),
real_estate_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (int_org_real_estate_usg_type_cd, dwh_valid_from_tmsp, real_estate_sid) NOT ENFORCED
) OPTIONS(description='This entity links internal organizations to the buildings in which they are located.');