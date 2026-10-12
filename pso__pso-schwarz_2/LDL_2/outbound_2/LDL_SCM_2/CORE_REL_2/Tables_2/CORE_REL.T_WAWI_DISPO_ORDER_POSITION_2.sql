CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_wawi_dispo_order_position_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique identifier of Lidl Country_2'),
country_cd STRING(160),
wh_nr STRING(20),
dispo_order_nr STRING(200) NOT NULL OPTIONS(description='Order number'),
seq_nr STRING(20) NOT NULL
OPTIONS(description='Consecutive numbers that are assigned by the dispo module when the order is generated'),
orig_item_nr BIGNUMERIC(38,0),
orig_supplier_nr STRING(20),
case_size BIGNUMERIC(38,5),
uom_cd STRING(20) OPTIONS(description='Unit_2 of measurement for the quantity of an item_2 that is ordered or purchased'),
order_qty BIGNUMERIC(38,5) OPTIONS(description='Ordered product quantity'),
deliv_dt DATE OPTIONS(description='Delivery Date'),
posted_dt DATE OPTIONS(description='The date when the delivery was recorded in the system.'),
order_status_cd STRING(20) OPTIONS(description='Order status_2 code '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (client_id, dispo_order_nr, seq_nr) NOT ENFORCED
) OPTIONS(description='A table that stores  detailed information about dispo orders');