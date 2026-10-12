CREATE OR REPLACE TABLE szd_production_core.t_fact_charger_report_analytical_per_month (
report_month INTEGER NOT NULL
OPTIONS(description='The calendar month as a number of the form YYYYMM, where YYYY is the calendar year and MM is month of the calendar year.'),
charger_provider_system_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charger provider system.'),
charging_station_owner_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charging station owner.'),
real_estate_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate.'),
country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the political country.'),
division_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.'),
charger_station_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the charging power type.'),
authentication_method_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the authentication method.'),
charger_classification_id INTEGER NOT NULL OPTIONS(description='Unique identifier of the classification of a charger.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The EUR currency code.'),
local_curr_cd STRING(3) NOT NULL OPTIONS(description='The code of the local currency.'),
provided_power_meas NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The sum of the provided/sold power (energy) by the charge point measured in kWh.'),
charging_process_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - The count of charging processes by the charge point.'),
charging_duration_sec_meas INTEGER NOT NULL
OPTIONS(description='Fact - additive - The sum of seconds of all charging processes.'),
charging_performance_meas NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The charging performance of the charging processes  measured in kWh.'),
turnover_eur_val NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The sum of the turnover amount of the charge point in EUR.'),
turnover_local_val NUMERIC(29,5) NOT NULL
OPTIONS(description='Fact - additive - The sum of the turnover amount of the charge point in the local currency.'),
customer_cnt INTEGER NOT NULL OPTIONS(description='Fact - semi additive - The count of different customers.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (report_month, charger_provider_system_cd, country_location_sid, real_estate_resource_item_sid,
 division_party_sid, authentication_method_cd, charger_station_type_cd, charging_station_owner_party_sid,
 charger_classification_id) NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity - by month, charging provider system, country, charging station type and plugin type. - Aggregate - Contains aggregatable facts for the\"Charger Report\". - Source - IOT Charger');