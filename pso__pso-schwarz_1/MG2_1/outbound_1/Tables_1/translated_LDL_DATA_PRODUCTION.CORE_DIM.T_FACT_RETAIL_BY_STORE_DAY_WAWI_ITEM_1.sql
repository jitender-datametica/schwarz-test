DROP TABLE IF EXISTS ldl_data_production_core_dim.t_fact_retail_by_store_day_wawi_item_1;
CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_fact_retail_by_store_day_wawi_item_1 (
bus_dt DATE NOT NULL OPTIONS(description='The business date to which the measures are related.'),
store_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store, which has generated the revenue.'),
wawi_item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the Wawi item.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization. (The business country_1 is not identical to a political country.) The country_1 organization is responsible for the store which has sold the Wawi item_1, and it is the organization which has created the Wawi item.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_1 for which the related country_1 organization is responsible. (The business country_1 is not identical to a political country.) The country_1 organization is responsible for the store which has sold the Wawi item_1, and it is the organization which has created the Wawi item.'),
sales_cnt INTEGER
OPTIONS(description='The number of Wawi items which have been sold in the given store on the given day. (This attribute is empty for weight-based products.)'),
sales_qty NUMERIC(29,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the Wawi items which have been sold in the given store on the given day. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
return_cnt INTEGER
OPTIONS(description='The number of Wawi items which have been returned in the given store on the given day. (This attribute is empty for weight-based products.)'),
return_qty NUMERIC(29,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the Wawi items which have been returned in the given store on the given day. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_sales_cnt INTEGER
OPTIONS(description='The number of Wawi items which have been sold in the given store on the given day. Only Wawi items with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This attribute is empty for weight-based products.)'),
perf_adj_sales_qty NUMERIC(29,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the Wawi items which have been sold in the given store on the given day. Only Wawi items with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_sales_net_val NUMERIC(29,5)
OPTIONS(description='The sales_1 portion of the net turnover which was generated for this Wawi item_1 in the given store on the given day. Only Wawi items with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_cnt INTEGER
OPTIONS(description='The number of Wawi item_1 which have been returned in the given store on the given day. Only Wawi items with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This attribute is empty for weight-based products.)'),
perf_adj_return_qty NUMERIC(29,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the Wawi items which have been returned in the given store on the given day. Only Wawi items with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_1 defined by the unit_1 of measure code)'),
perf_adj_return_net_val NUMERIC(29,5)
OPTIONS(description='The return portion of the net turnover which was generated for this Wawi item_1 in the given store on the given day. Only Wawi items with an international item_1 group or commission products with an absolute unit_1 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
uom_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the unit_1 of measure for weight based products. (kg, ...)'),
cash_register_sales_net_val NUMERIC(29,5)
OPTIONS(description='The sales_1 portion of the net turnover which was generated for this Wawi item_1 in the given store on the given day. (This is the amount according to the cash register.)'),
cash_register_sales_gross_val NUMERIC(29,5)
OPTIONS(description='The sales_1 portion of the gross turnover which was generated for this Wawi item_1 in the given store on the given day. (This is the amount according to the cash register.)'),
cash_register_return_net_val NUMERIC(29,5)
OPTIONS(description='The return portion of the net turnover which was generated for this Wawi item_1 in the given store on the given day. (This is the amount according to the cash register.)'),
cash_register_return_gross_val NUMERIC(29,5)
OPTIONS(description='The return portion of the gross turnover which was generated for this Wawi item_1 in the given store on the given day. (This is the amount according to the cash register.)'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
last_txn_tmsp TIMESTAMP
OPTIONS(description='The point in time when the last sales_1 transaction happend for this Wawi item_1 on the given day. This includes either sales_1 or returns. The timestamp is taken from end timestamp of the receipt header.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (bus_dt, store_sid, wawi_item_sid) NOT ENFORCED
) CLUSTER BY country_org_cd, bus_dt
OPTIONS(description='An aggregate fact holding basic retail measures per day, Wawi item_1 and store. This includes sales_1 and return volume and the gross and net turnover. (Turnover amounts are taken from the cash register.)');