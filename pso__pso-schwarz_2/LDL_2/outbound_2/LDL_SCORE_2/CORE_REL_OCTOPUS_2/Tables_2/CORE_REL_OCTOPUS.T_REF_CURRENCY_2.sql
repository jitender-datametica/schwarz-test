CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_ref_currency_2 (
curr_cd STRING(3) NOT NULL
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
curr_name STRING(100) OPTIONS(description='The full name of the currency'),
curr_name_de STRING(100) OPTIONS(description='English description of the currency EUR = Euro'),
curr_name_en STRING(100) OPTIONS(description='German description of the currency EUR = Euro'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (curr_cd) NOT ENFORCED
) OPTIONS(description='The ISO code for Currency');