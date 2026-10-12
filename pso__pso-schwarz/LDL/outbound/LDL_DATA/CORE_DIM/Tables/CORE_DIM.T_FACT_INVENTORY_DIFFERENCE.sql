/* --------------------------------------------------------------------------------
   DDL for table: t_fact_inventory_difference
   generated from Powerdesigner on Mittwoch, 5. März 2025 17:22:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_fact_inventory_difference (
inv_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the inventory event.'),
inv_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for inventories. It distinguishes between full and partial inventories.'),
inv_dt DATE NOT NULL OPTIONS(description='The date for which the inventory was done.'),
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store or warehouse, where the inventory was done.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country for which the related country organization is responsible. (The business country is not identical to a political country.) '),
calc_stock_net_val BIGNUMERIC(38,5)
OPTIONS(description='The total value of all products which should have been on stock in this internal organization (i.e. store or warehouse) on the inventory date. The value is based on the net sales prices that applies to this organization and on the calculated stock quantity. This measure is not additive across time!'),
inv_net_val BIGNUMERIC(38,5)
OPTIONS(description='The total value of all products which have been counted as part of the inventory process in this internal organization (i.e. store or warehouse) on the inventory date. The value is based on the net sales price that applies to this organization and and on the counted quantity. This measure is not additive across time! It is not necessarily in sync with the sum of the inventory amounts on product level.'),
inv_diff_net_val BIGNUMERIC(38,5)
OPTIONS(description='The net amount of the inventory difference, i.e. the difference between the value of the calculated stock and the counted stock. This measure is not necessarily in sync with the sum of the inventory differences on product level.'),
turnover_net_val BIGNUMERIC(38,5)
OPTIONS(description='The net turnover amount in the given currency which was generated in this internal organization (i.e. store or warehouse) for the inventory period. This is the consolidated amount after applying the priority logic. The turnover is the difference of sales and returns. (In case the internal organization references a warehouse, this is only that portion of the turnover which was generated directly in the warehouse. Turnover of stores which are managed by this warehouse, are not included.) The inventory period is the time interval between the last full inventory and this inventory. This measure is not necessarily in sync with the sum of the inventory turnover on product level.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (inv_sid) NOT ENFORCED
)
OPTIONS(description='A transactional fact holding inventory differences for full inventories in stores and warehouses. The inventory difference is the delta between the calculated stock and the stock that has been counted.');