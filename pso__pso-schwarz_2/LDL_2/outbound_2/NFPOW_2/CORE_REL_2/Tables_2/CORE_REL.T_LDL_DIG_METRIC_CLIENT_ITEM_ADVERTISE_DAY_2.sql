/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_dig_metric_client_item_advertise_day_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:40:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_dig_metric_client_item_advertise_day_2 (
metric_type_id BIGNUMERIC(38,0) NOT NULL,
ldl_dig_client_cd STRING(100) NOT NULL OPTIONS(description='Client code in the Lidl Digital DWH.'),
ldl_item_ian_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lidl International Item_2 Number (not necessarily unique in this table - numbers can be reused if an item_2 is cancelled, or multiple item_2 instances will be created for catalog items).'),
adv_dt DATE NOT NULL OPTIONS(description='Starting date of the advertising campaign.'),
metric_cnt BIGNUMERIC(38,0),
metric_qty BIGNUMERIC(38,5),
metric_val BIGNUMERIC(38,5),
curr_cd STRING(3) OPTIONS(description='Lidl currencies.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (metric_type_id, ldl_dig_client_cd, ldl_item_ian_nr, adv_dt) NOT ENFORCED
)
OPTIONS(description='Lidl Digital AVQ related metric data on the level web shop, IAN (Lidl international article number) and advertising day. These metrics are used to calculate the percentage of sold items in a prromotion (Abverkaufsquote).');