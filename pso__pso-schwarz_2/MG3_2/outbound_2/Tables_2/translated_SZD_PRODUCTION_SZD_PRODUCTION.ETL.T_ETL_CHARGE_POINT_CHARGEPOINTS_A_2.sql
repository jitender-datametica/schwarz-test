CREATE OR REPLACE TABLE szd_production_etl.t_etl_charge_point_chargepoints_a_2 (
resource_item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the charge point.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
charger_provider_system_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger provider system.'),
charger_resource_item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the charger.'),
charge_point_connector_type_id INTEGER NOT NULL OPTIONS(description='The unique code of the connector type.'),
charge_point_plugin_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code identifying the chargepoint connector plugin type.'),
charge_point_uuid_nr STRING(250) NOT NULL
OPTIONS(description='Natural/Business Key - Technical key of the chargepoint.'),
evse_nr STRING(250) OPTIONS(description='Descriptive Attribute - Electric Vehicle Supply Equipment Identifier'),
ocpp_id INTEGER OPTIONS(description='Descriptive Attribute - The identifier of the charge point within the charger.'),
connector_label_txt STRING(1000) OPTIONS(description='Descriptive Attribute - The label text of the connector.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (resource_item_sid, dwh_valid_from_tmsp) NOT ENFORCED
);