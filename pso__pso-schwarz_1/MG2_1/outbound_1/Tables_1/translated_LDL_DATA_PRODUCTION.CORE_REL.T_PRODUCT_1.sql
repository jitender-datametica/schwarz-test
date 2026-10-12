CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_product_1 (
prod_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
prod_type_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the discriminator for products.'),
item_type_cd STRING(20) OPTIONS(description='The code for the subtype discriminator for items.'),
prod_nr STRING(20) NOT NULL
OPTIONS(description='The number which (globally) identifies the product within the organization. (Note that the product number is unique for a certain point in time, but may be re_1-used later on.)'),
prod_name STRING(250) NOT NULL OPTIONS(description='The (global) name by which the product is marketed.'),
prod_descr STRING(250) OPTIONS(description='A more detailed (free text) description for the product.'),
prod_creation_dt DATE OPTIONS(description='The date when product was first listed.'),
packing_type_cd STRING(20) OPTIONS(description='The code identifying the way, how a product is packed.'),
goods_on_consignment_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the product is sold on behalf of a third party. Sales_1 revenue is directly transferred to this third party, who in turn, pays a commisson to the vending party.'),
excl_from_vat_calc_fg BOOL NOT NULL
OPTIONS(description='An indidcator showing, if the product should be excluded from the VAT calculation.'),
country_specific_prod_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the product has been defined by only one country_1 organization and is therefore available only in one country. (This does not include products, which are defined globally, but which happen to be sold in only one country.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (prod_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='The term „Product\"" describes goods and services which are offered by the enterprise. In the case of a retailer these are the goods the company trades with. The term “product” is not limited to the current assortment of goods and services, but may also include articles of competitors or articles which are currently not in the assortment.');