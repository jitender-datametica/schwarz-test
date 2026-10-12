CREATE OR REPLACE TABLE szd_production_core.t_fact_charge_point_snapshot_per_day_1 (
report_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
charger_provider_system_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger provider system.'),
charge_point_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charge point.'),
charger_resource_item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the charger'),
charging_station_owner_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charging station owner.'),
real_estate_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate.'),
country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the political country.'),
division_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.'),
charge_point_plugin_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger plugin type.'),
charge_point_power_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charging power type.'),
charger_station_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger station type.'),
charger_classification_id INTEGER NOT NULL OPTIONS(description='Unique identifier of the classification of a charger.'),
available_charge_point_cnt INTEGER NOT NULL
OPTIONS(description='Fact - semi additive - The count of available charge points for the report date.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (report_dt, charger_provider_system_cd, charge_point_resource_item_sid, charger_resource_item_sid,
 real_estate_resource_item_sid, country_location_sid, division_party_sid, charge_point_plugin_type_cd,
 charger_station_type_cd, charge_point_power_type_cd, charging_station_owner_party_sid, charger_classification_id)
NOT ENFORCED
)
OPTIONS(description='Fact table - Snapshot_1 - Granularity - by day and charge point. - Aggregate - Contains snapshot_1 facts regarding a charge point. - Source - IOT Charger');