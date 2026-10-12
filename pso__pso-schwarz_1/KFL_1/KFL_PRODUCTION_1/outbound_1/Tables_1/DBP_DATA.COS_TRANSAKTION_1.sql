--==============================================================
-- Table: cos_transaktion_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_transaktion_1
   generated from Powerdesigner on Mittwoch, 9. August 2023 12:17:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cos_transaktion_1 (
bonuspunkte_transaktion_id STRING(144) NOT NULL
OPTIONS(description='Unique key to identify a bonustransaction. Key to get from table bonustransactions to transactions table.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='KFL country_1 of the Loyalty Program.'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID of the store.'),
umsatz_brutto BIGNUMERIC(38,4) OPTIONS(description='Total bon value in gross.'),
bon_dat DATE OPTIONS(description='Creation date of the bon.'),
bon_barcode STRING(400) OPTIONS(description='Barcode number of the bon.'),
bon_nr BIGNUMERIC(38,0) OPTIONS(description='Full bon number.'),
umsatz_brutto_loyalty BIGNUMERIC(38,4)
OPTIONS(description='This is the sum on which points are calculated. In the future you can exclude e.g. items from the points calculation, so they make a separate sum for points calculations.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bonuspunkte_transaktion_id) NOT ENFORCED
) OPTIONS(description='Transactions on which bonus points are calculated. One row per transaction.');