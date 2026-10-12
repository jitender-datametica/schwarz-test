DROP TABLE IF EXISTS ldl_data_production_core_rel.t_inventory_result_1;
CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_inventory_result_1 (
inv_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the inventory event.'),
prod_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
inv_dt DATE NOT NULL OPTIONS(description='The date when the inventory is carried out.'),
inv_type_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the subtype discriminator for inventories.'),
int_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization, for which the inventory was done.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country_1 is not identical to a political country.)'),
inv_sales_unit_cnt NUMERIC(29,5)
OPTIONS(description='The number of sales_1 variants (that belong to the given product) which are actually on stock. E.g. if there are two boxes with 20 sales_1 variants each, the stock count is 40. For weight-based products this attribute is empty.'),
inv_diff_sales_unit_cnt NUMERIC(29,5)
OPTIONS(description='The inventory difference, expressed as the number of sales_1 variants (that belong to the given product). The inventory difference is the difference between the counted value and the calculated stock value. For weight-based products this attribute is empty.'),
inv_qty NUMERIC(29,5)
OPTIONS(description='The weight of the product which is actually on stock, expressed in the indicated unit_1 of measure. (This attribute is only filled for weight-based products.)'),
inv_diff_qty NUMERIC(29,5)
OPTIONS(description='The inventory difference, expressed in the indicated unit_1 of measure. The inventory difference is the difference between the counted value and the calculated stock value. This attribute is only filled for weight-based products.'),
uom_cd STRING(20) OPTIONS(description='The code identifying the unit_1 of measure for the inventory quantity.'),
inv_prod_reason_id INTEGER
OPTIONS(description='The identifier for the reason why an inventory was initiated for a certain product.'),
inv_result_status_type_id INTEGER
OPTIONS(description='The identifier for the counting status_1 of an inventory result. It shows, if the product could be counted.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (inv_sid, prod_sid, dwh_valid_from_tmsp) NOT ENFORCED
) CLUSTER BY inv_dt
OPTIONS(description='The inventory process produces counts for each product. The inventory result is shown either in kilograms (or any other unit_1 of measure describing weight) or as the number of sales_1 variants of the respective product. So if there are two boxes with 20 sales_1 item_1 each, the inventory count is 40.');