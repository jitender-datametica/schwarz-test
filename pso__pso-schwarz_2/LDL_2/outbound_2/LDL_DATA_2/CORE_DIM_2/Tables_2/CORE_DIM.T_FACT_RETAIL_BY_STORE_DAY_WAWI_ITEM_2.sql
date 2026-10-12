/* --------------------------------------------------------------------------------
   DDL for table: t_fact_retail_by_store_day_wawi_item_2
   generated from Powerdesigner on Thursday, May 22, 2025 4:53:29 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_fact_retail_by_store_day_wawi_item_2 (
bus_dt DATE NOT NULL OPTIONS(description='The business date to which the measures are related.'),
store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store, which has generated the revenue.'),
wawi_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the Wawi item.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_2 organization. (The business country_2 is not identical to a political country.) The country_2 organization is responsible for the store which has sold the Wawi item_2, and it is the organization which has created the Wawi item.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_2 for which the related country_2 organization is responsible. (The business country_2 is not identical to a political country.) The country_2 organization is responsible for the store which has sold the Wawi item_2, and it is the organization which has created the Wawi item.'),
sales_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of Wawi items which have been sold in the given store on the given day. (This attribute is empty for weight-based products.)'),
sales_qty BIGNUMERIC(38,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the Wawi items which have been sold in the given store on the given day. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
return_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of Wawi items which have been returned in the given store on the given day. (This attribute is empty for weight-based products.)'),
return_qty BIGNUMERIC(38,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the Wawi items which have been returned in the given store on the given day. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
perf_adj_sales_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of Wawi items which have been sold in the given store on the given day. Only Wawi items with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (This attribute is empty for weight-based products.)'),
perf_adj_sales_qty BIGNUMERIC(38,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the Wawi items which have been sold in the given store on the given day. Only Wawi items with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
perf_adj_sales_net_val BIGNUMERIC(38,5)
OPTIONS(description='The sales_2 portion of the net turnover which was generated for this Wawi item_2 in the given store on the given day. Only Wawi items with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
perf_adj_return_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of Wawi item_2 which have been returned in the given store on the given day. Only Wawi items with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (This attribute is empty for weight-based products.)'),
perf_adj_return_qty BIGNUMERIC(38,5)
OPTIONS(description='In case of weight-based products, this is the quantity of the Wawi items which have been returned in the given store on the given day. Only Wawi items with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (Quantity in the unit_2 defined by the unit_2 of measure code)'),
perf_adj_return_net_val BIGNUMERIC(38,5)
OPTIONS(description='The return portion of the net turnover which was generated for this Wawi item_2 in the given store on the given day. Only Wawi items with an international item_2 group or commission products with an absolute unit_2 price not between 0.0001 and 0.0315 EUR are considered. (This is the amount according to the cash register.)'),
uom_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the unit_2 of measure for weight based products. (kg, ...)'),
cash_register_sales_net_val BIGNUMERIC(38,5)
OPTIONS(description='The sales_2 portion of the net turnover which was generated for this Wawi item_2 in the given store on the given day. (This is the amount according to the cash register.)'),
cash_register_sales_gross_val BIGNUMERIC(38,5)
OPTIONS(description='The sales_2 portion of the gross turnover which was generated for this Wawi item_2 in the given store on the given day. (This is the amount according to the cash register.)'),
cash_register_return_net_val BIGNUMERIC(38,5)
OPTIONS(description='The return portion of the net turnover which was generated for this Wawi item_2 in the given store on the given day. (This is the amount according to the cash register.)'),
cash_register_return_gross_val BIGNUMERIC(38,5)
OPTIONS(description='The return portion of the gross turnover which was generated for this Wawi item_2 in the given store on the given day. (This is the amount according to the cash register.)'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
last_txn_tmsp TIMESTAMP
OPTIONS(description='The point in time when the last sales_2 transaction happend for this Wawi item_2 on the given day. This includes either sales_2 or returns. The timestamp is taken from end timestamp of the receipt header.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (bus_dt, store_sid, wawi_item_sid) NOT ENFORCED
) CLUSTER BY country_org_cd, bus_dt
OPTIONS(description='An aggregate fact holding basic retail measures per day, Wawi item_2 and store. This includes sales_2 and return volume and the gross and net turnover. (Turnover amounts are taken from the cash register.)');