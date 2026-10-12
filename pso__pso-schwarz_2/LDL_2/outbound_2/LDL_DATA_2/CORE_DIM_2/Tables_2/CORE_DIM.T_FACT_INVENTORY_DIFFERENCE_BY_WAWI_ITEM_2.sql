/* --------------------------------------------------------------------------------
   DDL for table: t_fact_inventory_difference_by_wawi_item_2
   generated from Powerdesigner on Dienstag, 29. April 2025 19:23:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_fact_inventory_difference_by_wawi_item_2 (
inv_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the inventory event.'),
inv_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for inventories. It distinguishes between full and partial inventories.'),
inv_dt DATE NOT NULL OPTIONS(description='The date for which the inventory was done.'),
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store or warehouse, where the inventory was done.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_2 for which the related country_2 organization is responsible. (The business country_2 is not identical to a political country.) '),
wawi_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the Wawi item.'),
calc_sales_unit_cnt BIGNUMERIC(38,5)
OPTIONS(description='The number of sales_2 units (that are related to the given Wawi item_2) which should have been on stock in this internal organization (i.e. store or warehouse) on the inventory date. E.g. if there are two boxes with 20 sales_2 variants each, the sales_2 unit_2 count is 40. For weight-based products this attribute is empty. This measure is not additive across time!'),
inv_sales_unit_cnt BIGNUMERIC(38,5)
OPTIONS(description='The number of sales_2 units (that are related to the given Wawi item_2) which have actually been on stock in this internal organization (i.e. store or warehouse) on the inventory date. E.g. if there are two boxes with 20 sales_2 variants each, the sales_2 unit_2 count is 40. For weight-based products this attribute is empty. This measure is not additive across time!'),
inv_diff_sales_unit_cnt BIGNUMERIC(38,5)
OPTIONS(description='The inventory difference, expressed as the difference in the number of sales_2 units for this internal organization (i.e. store or warehouse) and the given Wawi item_2 on the inventory date. E.g. if there are two boxes with 20 sales_2 variants each, the sales_2 unit_2 count is 40. The inventory difference is the difference between the counted quantity and the calculated stock quantity. For weight-based products this attribute is empty.'),
calc_qty BIGNUMERIC(38,5)
OPTIONS(description='The weight of the given Wawi item_2 which should have been on stock in this internal organization (i.e. store or warehouse) on the inventory date, expressed in the indicated unit_2 of measure. For piece-based products this measure is empty. This measure is not additive across time!'),
inv_qty BIGNUMERIC(38,5)
OPTIONS(description='The weight of the given Wawi item_2 which has actually been on stock in this internal organization (i.e. store or warehouse) on the inventory date, expressed in the indicated unit_2 of measure. For piece-based products this measure is empty. This measure is not additive across time!'),
inv_diff_qty BIGNUMERIC(38,5)
OPTIONS(description='The inventory difference, expressed as the difference in weight of the given Wawi item_2 in this internal organization (i.e. store or warehouse) on the inventory date. The weight is expressed in the indicated unit_2 of measure. The inventory difference is the difference between the counted quantity and the calculated stock quantity. For piece-based products this measure is empty.'),
uom_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the unit_2 of measure, such as kg, meter or pieces.'),
calc_stock_net_val BIGNUMERIC(38,5)
OPTIONS(description='The monetary value of the given Wawi items which should have been on stock in this internal organization (i.e. store or warehouse) on the inventory date. The value is based on the net sales_2 prices that applies to this organization and on the calculated stock quantity. This measure is not additive across time!'),
inv_net_val BIGNUMERIC(38,5)
OPTIONS(description='The monetary value of the given Wawi items which have been counted as part of the inventory process in this internal organization (i.e. store or warehouse) on the inventory date. The value is based on the net sales_2 price that applies to this organization and and on the counted quantity. This measure is not additive across time!'),
inv_diff_net_val BIGNUMERIC(38,5)
OPTIONS(description='The net amount of the inventory difference for the given Wawi items , i.e. the difference between the monetary value of the calculated stock and the counted stock.'),
turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='The net turnover amount in the given currency which was generated in this internal organization (i.e. store or warehouse) for the given Wawi items in the inventory period. This is the amount delivered by the cash registers. The turnover is the difference of sales_2 and returns. (In case the internal organization references a warehouse, this is only that portion of the turnover which was generated directly in the warehouse. Turnover of stores which are managed by this warehouse, are not included.) The inventory period is the time interval between the last full inventory and this inventory.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (inv_sid, wawi_item_sid) NOT ENFORCED
) CLUSTER BY inv_dt
OPTIONS(description='A transactional fact holding inventory differences on the level of Wawi items for full and partial inventories in stores and warehouses. The inventory difference is the delta between the calculated stock and the stock that has been counted.');