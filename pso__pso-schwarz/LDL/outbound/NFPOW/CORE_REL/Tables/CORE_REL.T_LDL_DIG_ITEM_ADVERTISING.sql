/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_dig_item_advertising
   generated from Powerdesigner on Dienstag, 3. Dezember 2024 19:26:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_dig_item_advertising (
ldl_dig_adv_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the advertise campaign in the Lidl Digital DWH.'),
ldl_dig_item_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the product variant in the Lidl Digital DWH.'),
ldl_dig_client_cd STRING(100) NOT NULL OPTIONS(description='Client code in the Lidl Digital DWH.'),
ldl_item_ian_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lidl International Item Number (not necessarily unique in this table - numbers can be reused if an item is cancelled, or multiple item instances will be created for catalog items).'),
adv_status_cd STRING(100) NOT NULL OPTIONS(description='Status of the advertising campaign.'),
adv_dt DATE NOT NULL OPTIONS(description='Starting date of the advertising campaign in the extract from Lidl Digital.'),
adv_sales_reservation_start_dt DATE NOT NULL
OPTIONS(description='Start date of the phase advertising campaign when customers can preorder the product, in the extract from Lidl Digital.'),
adv_sales_start_dt DATE NOT NULL
OPTIONS(description='Reference date of the advertising campaign to distinguish between regular orders and preorders, in the extract from Lidl Digital.'),
adv_sales_end_dt DATE
OPTIONS(description='End date of the phase of the advertising campaign when customers can order the item using the conditions of the advertising campaign, in the extract from Lidl Digital.'),
adv_stock_qty BIGNUMERIC(38,5) OPTIONS(description='Value of the metric if it is a quantity.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_dig_adv_id, ldl_dig_item_variant_sid) NOT ENFORCED
)
OPTIONS(description='Lidl Digital AVQ (Abverkaufsquote) related data on the level web shop, IAN (Lidl international article number) and advertise day. The dates are used to calculate the percentage of items sold in a promotion (AVQ / sales quota).');