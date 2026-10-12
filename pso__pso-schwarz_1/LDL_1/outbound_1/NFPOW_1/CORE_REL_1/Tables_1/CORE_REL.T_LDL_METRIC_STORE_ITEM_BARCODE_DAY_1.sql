/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_metric_store_item_barcode_day_1
   generated from Powerdesigner on Montag, 30. September 2024 17:22:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_metric_store_item_barcode_day_1 (
metric_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='identifier of the metric in the NFPOW database'),
ldl_store_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='surrogate key of the store in the Lidl DWH'),
ldl_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='surrogate key of the item_1 in the Lidl DWH'),
ldl_barcode_nr STRING(100) NOT NULL
OPTIONS(description='String provided by the cash register. Contains in general the scanned GTIN of the item_1, but in some cases the local item_1 number or other identifiers of the goods or processes the receiptline is related to.'),
cal_dt DATE NOT NULL OPTIONS(description='calendar_1 date of the fact in the extract from Lidl retail DWH'),
metric_cnt BIGNUMERIC(38,0) OPTIONS(description='value of the metric if it is a counted number'),
metric_qty BIGNUMERIC(38,5) OPTIONS(description='value of the metric if it is a quantity'),
metric_val BIGNUMERIC(38,5) OPTIONS(description='value of the metric if it is an amount'),
metric_price BIGNUMERIC(38,5) OPTIONS(description='value of the metric if it is a price'),
metric_rate BIGNUMERIC(38,5) OPTIONS(description='value of the metric if it is a rate'),
curr_cd STRING(3) OPTIONS(description='currency code used by Lidl'),
ldl_client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key of the ERP client in the Lidl DWH'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (metric_type_id, ldl_store_sid, ldl_item_sid, cal_dt, ldl_barcode_nr) NOT ENFORCED
)
OPTIONS(description='common metric table to store extraction results from the Lidl DWH for every metric on the level store, item_1, scanned barcode and day represented by the surrogate identifiers used in the Lidl DWH');