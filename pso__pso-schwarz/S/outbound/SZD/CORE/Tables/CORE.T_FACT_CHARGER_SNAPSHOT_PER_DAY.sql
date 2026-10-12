/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CHARGER_SNAPSHOT_PER_DAY
   generated from Powerdesigner on Mittwoch, 9. Juli 2025 13:57:53
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_charger_snapshot_per_day (
report_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
charger_provider_system_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger provider system.'),
charger_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charge point.'),
charging_station_owner_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charging station owner.'),
real_estate_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate.'),
country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the political country.'),
division_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.'),
charger_station_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger station type.'),
charger_classification_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier of the classification of a charger.'),
available_charger_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - semi additive - Count of available charging stations (per day).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (report_dt, charger_provider_system_cd, charger_resource_item_sid, charging_station_owner_party_sid,
 real_estate_resource_item_sid, country_location_sid, division_party_sid, charger_station_type_cd,
 charger_classification_id) NOT ENFORCED
)
OPTIONS(description='Fact table - Snapshot - Granularity - by day and charging station. - Aggregate - Contains snapshot facts regarding a charger. - Source - IOT Charger');