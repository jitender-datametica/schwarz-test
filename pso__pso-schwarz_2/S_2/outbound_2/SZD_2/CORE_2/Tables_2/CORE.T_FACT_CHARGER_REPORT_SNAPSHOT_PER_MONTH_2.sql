/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CHARGER_REPORT_SNAPSHOT_PER_MONTH_2
   generated from Powerdesigner on Mittwoch, 9. Juli 2025 09:56:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_charger_report_snapshot_per_month_2 (
report_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_2 month as a number of the form YYYYMM, where YYYY is the calendar_2 year and MM_2 is month of the calendar_2 year.'),
charger_provider_system_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger provider system.'),
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
OPTIONS(description='Fact - semi additive - Count of available chargers.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (report_month, charger_provider_system_cd, country_location_sid, charger_station_type_cd,
 charging_station_owner_party_sid, real_estate_resource_item_sid, division_party_sid, charger_classification_id)
NOT ENFORCED
)
OPTIONS(description='Fact table - Snapshot_2 - Granularity - by month, charging provider system, country_2, charging station type and plugin type. - Aggregate - Contains snapshot_2 facts for the "Charger Report". - Source - IOT Charger');