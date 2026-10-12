CREATE OR REPLACE TABLE szd_production_core.t_dim_charger (
resource_item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the charger'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
charger_provider_system_cd STRING(50) NOT NULL
OPTIONS(description='Natural/Business Key - The unique code of the charger provider system.'),
charging_station_owner_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charging station owner.'),
real_estate_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate.'),
charger_station_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger station type.'),
charger_station_type_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute - The name of the charger station type.'),
charger_uuid_nr STRING(250) NOT NULL OPTIONS(description='Natural/Business Key - Technical key of the charger.'),
charger_label_nr STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - The label of the charger containing informations about the division and the associated real estate.'),
public_display_name STRING(100) OPTIONS(description='Descriptive Attribute -  The public display name of the charger.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (resource_item_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - A charger (or charging station) is a device usually located at parking lots at stores or in parking garages where you can charge your electrical car. - Source - IOT Charger');