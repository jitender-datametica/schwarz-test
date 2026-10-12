DROP TABLE IF EXISTS ldl_data_production_core_rel.t_write_off_event;
CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_write_off_event (
int_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization where the write-off happened. This can be either a store or a delivery company. The type of internal organization is defined by the int_org_type_cd.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
deliv_company_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the delivery company, to which the write-off is related. In case of a write-off in a warehouse, this is the same as the int_org_sid. In case of a write-off in a store, this is the associated delivery company of the store.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country is not identical to a political country.)'),
real_estate_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
write_off_dt DATE NOT NULL OPTIONS(description='The date when the write-off was recorded.'),
bus_dt DATE NOT NULL OPTIONS(description='The day to which the write-off is accrued.'),
curr_stat_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this is the current record(s) for the given key. Filtering on this flag returns the statistics after any corrections.'),
correction_seq INTEGER
OPTIONS(description='In case multiple corrections apply to one base record, this is the sequence of the correction.'),
receipt_nr INTEGER NOT NULL OPTIONS(description='The number of the receipt which tracks the write-off.'),
receipt_line_nr INTEGER NOT NULL
OPTIONS(description='The number of the positon on the receipt which tracks the write-off.'),
write_off_event_type_id INTEGER NOT NULL
OPTIONS(description='The code identifying the type of write off event. (There are write offs for stores and write offs for warehouses.)'),
write_off_reason_id INTEGER NOT NULL OPTIONS(description='The identifier for the reason why products are written off.'),
write_off_qty NUMERIC(29,5)
OPTIONS(description='In case the product is sold by weight instead of pieces, this is the quantity of the product which was written off. E.g. 2 kg'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit of measure.'),
write_off_net_val NUMERIC(29,5) NOT NULL OPTIONS(description='The net amount which was written off.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
logistic_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the logistic variant of a product which is written off.'),
write_off_sales_unit_cnt INTEGER
OPTIONS(description='The number of sales variants (contained in this logistic variant) which were written off. In case the product is sold by weight instead of pieces, this attribute is empty.'),
part_write_off_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the write off was partial or in full.'),
wawi_item_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the Wawi item variant which is written off.'),
PRIMARY KEY (int_org_sid, bus_dt, write_off_dt, receipt_nr, receipt_line_nr) NOT ENFORCED
) CLUSTER BY bus_dt
OPTIONS(description='If products break or for some other reason are considered not suitable for sale any more, they need to be written off.');