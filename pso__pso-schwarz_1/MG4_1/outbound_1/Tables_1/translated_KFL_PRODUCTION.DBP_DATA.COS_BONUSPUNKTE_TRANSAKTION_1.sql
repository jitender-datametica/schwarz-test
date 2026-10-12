CREATE OR REPLACE TABLE kfl_production_dbp_data.cos_bonuspunkte_transaktion_1 (
crm_konto_id STRING(144) NOT NULL OPTIONS(description='The ID of the loyalty account.'),
datzeit_bonuspunkte_transaktion TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the points.'),
mandant_id INTEGER NOT NULL OPTIONS(description='KFL country_1 where the bonus transaction happens.'),
bonuspunkte_transaktion_id STRING(144)
OPTIONS(description='Unique key to identify a bonustransaction. Key to get from table bonustransactions to transactions table.'),
anz_bonuspunkte_transaktion INTEGER OPTIONS(description='Total value of the bonus transaction.'),
bonuspunkte_transaktion_richtung INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Shows the direction of the bonus transaction (1 = earn, 2 = burn).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
datzeit_update TIMESTAMP
OPTIONS(description='timestamp of when the record was last updated in the source system. it is used to monitor the correctness of the loading process by comparing what is in the dwh and in the source.'),
PRIMARY KEY (crm_konto_id, datzeit_bonuspunkte_transaktion) NOT ENFORCED
) OPTIONS(description='Bonus points awarded or spent by customer per transaction.');