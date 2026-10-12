/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CHARGE_LOG_SNAPSHOT_PER_DAY
   generated from Powerdesigner on Dienstag, 9. September 2025 11:27:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_charge_log_snapshot_per_day (
report_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
charger_provider_system_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger provider system.'),
charger_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charge point.'),
charge_point_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charge point.'),
charging_station_owner_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charging station owner.'),
real_estate_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate.'),
country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the political country.'),
division_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.'),
authentication_method_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the authentication method.'),
charge_point_plugin_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger plugin type.'),
charge_point_power_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charging power type.'),
charger_station_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger station type.'),
charger_classification_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier of the classification of a charger.'),
relevance_fg BOOL NOT NULL
OPTIONS(description='A flag indicating this log entry is relevant to be considered in reporting.'),
active_charger_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - semi additive - Count of active charging stations (per day and charger).'),
active_charge_point_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - semi additive - Count of active charge points (per day and charge point).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (report_dt, charger_provider_system_cd, charger_resource_item_sid, authentication_method_cd,
 charging_station_owner_party_sid, real_estate_resource_item_sid, country_location_sid, division_party_sid,
 charge_point_resource_item_sid, charge_point_plugin_type_cd, charge_point_power_type_cd, charger_station_type_cd,
 charger_classification_id) NOT ENFORCED
)
OPTIONS(description='Fact table - Snapshot - Granularity - by day, authentication method and charging station. - Aggregate - Contains snapshot facts regarding a charger. - Source - IOT Charger');