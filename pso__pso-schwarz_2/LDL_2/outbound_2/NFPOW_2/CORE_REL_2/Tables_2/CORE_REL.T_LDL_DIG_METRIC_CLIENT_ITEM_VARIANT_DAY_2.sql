/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_dig_metric_client_item_variant_day_2
   generated from Powerdesigner on Dienstag, 3. Dezember 2024 19:26:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_dig_metric_client_item_variant_day_2 (
metric_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier of the metric in the NFPOW database.'),
ldl_dig_client_cd STRING(100) NOT NULL OPTIONS(description='Client code in the Lidl Digital DWH.'),
ldl_dig_item_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key prod_variant_sid in the source system. This column is necessary to provide a PK without leaving level of detail in the data.'),
cal_dt DATE NOT NULL OPTIONS(description='Date of sales_2 or return events in Lidl Digital before extract aggregation.'),
ldl_item_ian_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lidl International Item_2 Number (not necessarily unique in this table - numbers can be reused if an item_2 is cancelled, or multiple item_2 instances will be created for catalog items).'),
ldl_dig_gtin_nr STRING(100)
OPTIONS(description='EAN_2 / GTIN number of the product variant as provided in the source at the time of extraction. The stored number sometimes contains special characters for Lidl Digital specific reasons.'),
metric_cnt BIGNUMERIC(38,0) OPTIONS(description='Value of the metric if it is a counted number.'),
metric_qty BIGNUMERIC(38,5) OPTIONS(description='Value of the metric if it is a quantity.'),
metric_val BIGNUMERIC(38,5) OPTIONS(description='Value of the metric if it is an amount.'),
curr_cd STRING(3) OPTIONS(description='Lidl currencies.            LDL: p_lew_core.t_currency.curr_iso_cd'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (metric_type_id, ldl_dig_client_cd, ldl_dig_item_variant_sid, cal_dt) NOT ENFORCED
)
OPTIONS(description='Lidl Digital AV (Abverkauf) related metric data on the level web shop, Lidl Digital product variant and advertise day. These metrics are used to calculate certain KPIs including the percentage of items sold in a promotion (AVQ / sales_2 quota).');