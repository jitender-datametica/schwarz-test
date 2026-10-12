CREATE OR REPLACE TABLE kfl_production_dbp_data.aad_cashier_id_mapping_1 (
hashed_cashier_id STRING(255) NOT NULL OPTIONS(description='Encrypted (hashed) CashierID'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land.'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
kassierer_nr STRING(4) NOT NULL OPTIONS(description='Nummer des Kassierers.'),
hash_generation_dt DATE OPTIONS(description='Last date of the generation of the hashed CashierID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (hashed_cashier_id) NOT ENFORCED
) OPTIONS(description=' Contains pseudonymise cashier number');