CREATE OR REPLACE TABLE szd_production_core.t_fact_charge_point_analytical_per_day_1 (
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
authentication_method_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the authentication method.'),
charge_point_plugin_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger plugin type.'),
charge_point_power_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charging power type.'),
charger_station_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger station type.'),
charger_classification_id INTEGER NOT NULL OPTIONS(description='Unique identifier of the classification of a charger.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The EUR currency code.'),
local_curr_cd STRING(3) NOT NULL OPTIONS(description='The currence code of the local currency.'),
provided_power_meas NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The sum of the provided/sold power (energy) by the charge point measured in kWh.'),
charging_process_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - The count of charging processes by the charge point.'),
charging_duration_sec_meas NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The sum of seconds of all charging processes.'),
charging_performance_meas NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The charging performance of the charging processes  measured in kWh.'),
turnover_eur_val NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The sum of the turnover amount of the charge point in EUR.'),
turnover_local_val NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The sum of the turnover amount of the charge point in the local currency.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (report_dt, charger_provider_system_cd, charge_point_resource_item_sid, charger_resource_item_sid,
 charging_station_owner_party_sid, real_estate_resource_item_sid, country_location_sid, division_party_sid,
 authentication_method_cd, charge_point_plugin_type_cd, charge_point_power_type_cd, charger_station_type_cd,
 charger_classification_id) NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity - by day, authentication method, charger station type, plugin type, charge point - Aggregate - Contains analytical facts regarding a charge point. - Source - IOT Charger');