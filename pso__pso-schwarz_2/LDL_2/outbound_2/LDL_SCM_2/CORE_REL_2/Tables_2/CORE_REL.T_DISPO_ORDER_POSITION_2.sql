/* --------------------------------------------------------------------------------
   DDL for table: t_dispo_order_position_2
   generated from Powerdesigner on Donnerstag, 28. August 2025 15:19:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_dispo_order_position_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique identifier of Lidl Country_2'),
country_cd STRING(160) OPTIONS(description='The code identifying the country_2 according to ISO 3166.'),
wh_nr STRING(20) OPTIONS(description='The number of a warehouse in WAWI'),
dispo_order_nr STRING(200) NOT NULL OPTIONS(description='Order number in dource system WAWI/LeXXI'),
dispo_order_pos_nr STRING(20) NOT NULL
OPTIONS(description='Consecutive numbers that are assigned by the dispo module when the order is generated'),
orig_item_nr BIGNUMERIC(38,0) OPTIONS(description='A short item_2 number from Wawi'),
orig_supplier_nr STRING(20) OPTIONS(description='A number identifying supplier_2 in Wawi'),
case_size BIGNUMERIC(38,5)
OPTIONS(description='The number of individual items that are contained in the logistic variant. (Note that the individual item_2 represents the smallest sellable unit. E.g. if a packed try of meat contains two slices, the entire tray is considered one sellable unit.)'),
case_per_pallet_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of cases which can be packed on a standard pallet. '),
src_ian_nr STRING(20) OPTIONS(description='International Article Number'),
src_gtin_nr STRING(20) OPTIONS(description='The Global Trade Item_2 Number (GTIN) that identifies this item_2 variant.'),
uom_cd STRING(20) OPTIONS(description='Unit_2 of measurement for the quantity of an item_2 that is ordered or purchased'),
order_qty BIGNUMERIC(38,5) OPTIONS(description='Ordered product quantity'),
deliv_dt DATE OPTIONS(description='Delivery Date'),
posted_dt DATE OPTIONS(description='The date when the delivery was recorded in the system.'),
order_status_cd STRING(20) OPTIONS(description='Order status_2 code '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (client_id, dispo_order_nr, dispo_order_pos_nr) NOT ENFORCED
) OPTIONS(description='A table that stores  detailed information about dispo orders');