CREATE OR REPLACE TABLE szd_production_core.t_fact_charge_log_events_2 (
charger_provider_system_cd STRING(50) NOT NULL
OPTIONS(description='Natural/Business Key - The unique code of the charger provider system.'),
charge_log_uuid_nr STRING(50) NOT NULL
OPTIONS(description='Natural/Business Key - The unique identifier of the charge log event.'),
charge_event_dt DATE NOT NULL
OPTIONS(description='Descriptive Attribute - The date of the charging event (Determined from the local end timestamp).'),
start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Descriptive Attribute - The start timestamp of the loading process.'),
end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Descriptive Attribute - The end timestamp of the loading process.'),
charger_resource_item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the charger'),
charger_classification_id INTEGER NOT NULL OPTIONS(description='Unique identifier of the classification of a charger.'),
charger_serial_nr STRING(50)
OPTIONS(description='Descriptive Attribute - The serial number of the charger the charge log event occurs.'),
charger_label_nr STRING(250) OPTIONS(description='Descriptive Attribute - The label of the charging station.'),
charger_station_type_cd STRING(50)
OPTIONS(description='Descriptive Attribute - The unique code of the charger station type.'),
division_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division.'),
division_name STRING(100) OPTIONS(description='Descriptive Attribute - The name of the division.'),
country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the political country.'),
country_iso_cd STRING(3)
OPTIONS(description='Descriptive Attribute - The ISO code of the country_2 of the charger station.'),
internal_company_name STRING(100) OPTIONS(description='Descriptive Attribute - The name of the interal company unit.'),
real_estate_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate.'),
real_estate_nr STRING(50)
OPTIONS(description='Descriptive Attribute - The business number of the real estate (e.g. store number).'),
real_estate_zip STRING(15)
OPTIONS(description='Descriptive Attribute - The zip code (postal area code) of the real estate.'),
real_estate_city_name STRING(100)
OPTIONS(description='Descriptive Attribute - The name of the city where the real estate is located.'),
real_estate_street_name STRING(100)
OPTIONS(description='Descriptive Attribute - The name of the street including the house number of the real estate.'),
charge_point_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charge point.'),
charge_point_plugin_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the plugin type of the charge point.'),
charge_point_nr INTEGER
OPTIONS(description='Descriptive Attribute - The number of the charge point of the charger station (usually 1, 2 or 3).'),
charge_point_evse_nr STRING(250)
OPTIONS(description='Descriptive Attribute - Electric Vehicle Supply Equipment Identifier'),
charge_point_connector_label_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - The connector label of the charge point.'),
roaming_identification_data_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - The roaming identification data (RFID tag_2).'),
customer_uuid_nr STRING(250)
OPTIONS(description='Descriptive Attribute - The unique business identifier of the customer application.'),
duration_sec INTEGER NOT NULL OPTIONS(description='Fact - additive - The duration of the charging process in seconds.'),
total_charging_power_meas NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The provided amount of power for the charging process measured in kilowatt.'),
average_charging_power_meas NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - non additive - The average power for the charging process measured in kilowatt per hour.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The EUR currency code.'),
local_curr_cd STRING(3) NOT NULL OPTIONS(description='The local currency code.'),
turnover_val NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The turnover amount of the charging process in EUR.'),
turnover_local_val NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The turnover amount of the charging process in the local currency.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (charger_provider_system_cd, charge_log_uuid_nr) NOT ENFORCED
)
OPTIONS(description='Fact table - Transactional Events - This table contains detailed informationen of charge log events.  - Source - IOT Charger');