/* --------------------------------------------------------------------------------
   DDL for table: t_wawi_stock_2
   generated from Powerdesigner on Donnerstag, 13. März 2025 15:51:03
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_wawi_stock_2 (
wawi_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the Wawi item.'),
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_2 organization which is responsible for the internal organization on which stock is tracked.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)'),
bus_dt DATE NOT NULL OPTIONS(description='The date for which the stock quanity is calculated.'),
stock_sales_unit_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of individual items (that belong to the given Wawi item_2) which are on stock. E.g. if there are two boxes with 20 sales_2 variants each, the stock count is 40. For weight-based products this attribute is empty.'),
stock_qty BIGNUMERIC(38,5)
OPTIONS(description='The weight of the Wawi item_2 which is on stock in the given store or warehouse, expressed in the indicated unit_2 of measure. (This attribute is only filled for weight-based products.)'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit_2 of measure for the stock quantity.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (wawi_item_sid, int_org_sid, bus_dt) NOT ENFORCED
) CLUSTER BY country_org_cd, bus_dt
OPTIONS(description='The Wawi stock entity describes, how many units of a certain Wawi item_2 exist in a store or in a warehouse (i.e. a delivery company). Stock is shown either in kilograms (or any other unit_2 of measure describing weight) or as the number of sales_2 variants of the respective Wawi product. So if there are two boxes with 20 sales_2 item_2 each, the stock count is 40. Stock is calculated from one day to another and shows the quantity that should exist at the end of the business day. An inventory may correct the stock.');