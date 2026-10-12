--==============================================================
-- Table: aad_cashier_id_mapping_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_cashier_id_mapping_2
   generated from Powerdesigner on Mittwoch, 10. Mai 2023 08:38:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aad_cashier_id_mapping_2 (
hashed_cashier_id STRING(255) NOT NULL OPTIONS(description='Encrypted (hashed) CashierID'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land.'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
kassierer_nr STRING(4) NOT NULL OPTIONS(description='Nummer des Kassierers.'),
hash_generation_dt DATE OPTIONS(description='Last date of the generation of the hashed CashierID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (hashed_cashier_id) NOT ENFORCED
) OPTIONS(description=' Contains pseudonymise cashier number');