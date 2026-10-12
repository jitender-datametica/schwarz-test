CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_fact_real_estate_lifecycle (
real_estate_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
real_estate_nr STRING(20) NOT NULL
OPTIONS(description='The number which uniquely identifies a real estate object within a country organization.'),
real_estate_name STRING(100) NOT NULL OPTIONS(description='The name for the real estate object.'),
real_estate_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for real estate objects.'),
real_estate_status_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the lifecycle status for real estate objects. (This is the business lifecycle, so it might differ from the status code shown in the source system.)'),
precontract_dt DATE
OPTIONS(description='The date when the precontract / letter of intent for this real estate object was signed.'),
contract_dt DATE OPTIONS(description='The date when the contract for this real estate object was signed.'),
construction_start_dt DATE OPTIONS(description='The date when construction started for this real estate object.'),
construction_end_dt DATE OPTIONS(description='The date when construction finished for this real estate object.'),
planned_open_dt DATE OPTIONS(description='The date when this real estate object was intended to open.'),
open_dt DATE OPTIONS(description='The date when this real estate object was opened.'),
opening_reason_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the reason why a real estate object has been opened. (E.g. it was a new building, or it replaced an existing building.)'),
temp_closing_start_dt DATE
OPTIONS(description='The date of the beginning of the last temporary closing period for this real estate object.'),
temp_closing_end_dt DATE
OPTIONS(description='The date of the end of the last temporary closing period for this real estate object.'),
closed_bus_days_cnt INTEGER OPTIONS(description='The number of business days the real estate object remained closed.'),
temp_closing_reason_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the reason, why a real estate object has been temporarily closed.'),
planned_close_dt DATE OPTIONS(description='The date when this real estate object was inteded to be closed.'),
close_dt DATE OPTIONS(description='The date when this real estate object was closed.'),
closing_reason_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the reason, why a real estate object has been (permanently) closed.'),
project_cancel_dt DATE
OPTIONS(description='The date when the Schwarz Group had no intention to build a real estate object any more, i.e. when the project was cancelled.'),
project_cancel_reason_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the reason, why a real estate project was (pre-maturely) terminated.'),
project_term_dt DATE
OPTIONS(description='The date when the project was terminated, i.e. when the real estate object was closed and there were no legal obligations any more.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (real_estate_sid) NOT ENFORCED
) OPTIONS(description='This (accumulating snapshot) fact tracks the lifecycle of a real estate object');