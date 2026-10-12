CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_fact_wawi_item_variant_sales_price (
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country for which the related country organization is responsible. (The business country is not identical to a political country.)'),
wawi_item_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the Wawi item variant.'),
wawi_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the Wawi item.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
sales_net_price BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The net price (i.e. excluding VAT) for which products that are related to the Wawi item variant are sold in the given store or warehouse.'),
sales_gross_price BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The gross price (i.e. including VAT) for which products that are related to the Wawi item variant are sold in the given store or warehouse.'),
deposit_val BIGNUMERIC(38,5)
OPTIONS(description='The deposit amount for this Wawi item variant. E.g. 25c for a plastic bottle. (This attribute is only filled, if there is a deposit.)'),
tax_pct BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The actual tax percentage which is applicable for the Wawi item variant in the given store or warehouse. (In case several taxes apply, this is the total tax percentage.)'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (int_org_sid, wawi_item_variant_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A derived table tracking the sales prices of Wawi item variants in stores and warehouses. (For reasons of data volume this table does not contain one record per day, but is historized.)');