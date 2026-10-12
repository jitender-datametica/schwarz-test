CREATE OR REPLACE TABLE ldl_data_production_core_app_fraud_detection.t_cashier_encryption_2 (
cashier_hash STRING(32) NOT NULL
OPTIONS(description='Pseudonymization via country_2 ISO code, store number, cashier number, date (e.g. DE | 1207 | 04 | 2024-04-06) via MD5.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the retail event happend.'),
store_nr STRING(20) NOT NULL
OPTIONS(description='Natural key of the store the was valid point in time of the hashing or the store number which appear in the receipt (as internal organization). '),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country_2 is not identical to a political country.)'),
cashier_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the cashier. (The number is unique for a given store and a day.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cashier_hash) NOT ENFORCED
) OPTIONS(description='A line, which logs the sale or return of a single product within a retail event.');