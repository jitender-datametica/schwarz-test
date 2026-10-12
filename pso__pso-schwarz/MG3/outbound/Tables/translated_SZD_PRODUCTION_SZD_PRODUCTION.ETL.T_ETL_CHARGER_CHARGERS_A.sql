CREATE OR REPLACE TABLE szd_production_etl.t_etl_charger_chargers_a (
resource_item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the resource item.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
charger_uuid_nr STRING(250) NOT NULL OPTIONS(description='Natural/Business Key - Technical key of the charger.'),
charger_provider_system_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger provider system.'),
charger_model_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item.'),
real_estate_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item.'),
charger_communication_status_id INTEGER NOT NULL
OPTIONS(description='The unique ID of the communication status of a charger.'),
charger_communication_type_id INTEGER NOT NULL
OPTIONS(description='The unique code of the communication type of a charger.'),
charging_station_owner_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charging station owner.'),
charger_dlsoftware_nr INTEGER NOT NULL OPTIONS(description='Descriptive Attribute - Technical key of the DL software'),
charger_els_nr STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - Technical key of ELS (ELS = Elektronische Ladesäule)'),
label_nr STRING(250) NOT NULL
OPTIONS(description='The label of the charger containing informations about the division and the associated real estate.'),
public_display_name STRING(100) OPTIONS(description='Descriptive Attribute -  The public display name of the charger.'),
max_charge_power_meas NUMERIC(29,5) OPTIONS(description='The maximum power of the charger in kW.'),
serial_nr STRING(250) OPTIONS(description='Descriptive Attribute - The serial number of the charger.'),
firmware_version_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - The firmware version used in the charger'),
analytic_account_txt STRING(1000) OPTIONS(description='Descriptive Attribute - The company used for analysis '),
imsi_nr STRING(250) OPTIONS(description='Descriptive Attribute - International Mobile Subscriber Identity'),
icc_nr STRING(250) OPTIONS(description='Descriptive Attribute - ICC ID of the charger.'),
meter_type_nr STRING(250) OPTIONS(description='Descriptive Attribute - The number of the meter type.'),
meter_serial_nr STRING(250) OPTIONS(description='Descriptive Attribute - The serial number of the meter.'),
last_heartbeat_tmsp TIMESTAMP
OPTIONS(description='Descriptive Attribute - Timestamp of the last heartbeat of the charger'),
heartbeat_interval_sec INTEGER OPTIONS(description='Descriptive Attribute - The interval of the heartbeat in seconds.'),
ip_address_nr STRING(250) OPTIONS(description='Descriptive Attribute - The IP address of the charger'),
created_at_tmsp TIMESTAMP
OPTIONS(description='Descriptive Attribute - Technical timestamp when this record was created in the source'),
updated_at_tmsp TIMESTAMP
OPTIONS(description='Descriptive Attribute - Technical timestamp when this record was updated in the source'),
installation_dt DATE OPTIONS(description='Descriptive Attribute - The date of installation of the charger'),
commissioing_dt DATE OPTIONS(description='Descriptive Attribute - The date of commissioning the charger'),
cpo_operation_cost_rate_val NUMERIC(29,5)
OPTIONS(description='Descriptive Attribute - Operations cost rate of the CPO.'),
sit_internal_ip_address_nr STRING(250) OPTIONS(description='Descriptive Attribute - SIT internal IP address'),
operator_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute - Name of the operator of the charger (usually a country organisation).'),
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