CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_local_product_2 (
prod_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
int_org_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
local_prod_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the product within the given market / internal organization. (i.e. the local item_2 number)  Note that the product number is unique for a certain point in time, but may be re_2-used later on.'),
add_nr_exist_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if other numbers exist for this product in addition to the local product number. (If this flag is true, then the additional numbers are stored in the Product Identification table.)'),
local_prod_name STRING(250) NOT NULL
OPTIONS(description='The name by which the product is marketed within the given market / internal organization. (This is the local product name.)'),
local_prod_descr STRING(250)
OPTIONS(description='A more detailed (free text) description for the product - which applies to the given market / internal organization.'),
local_prod_version_nr STRING(20)
OPTIONS(description='The version number of the product in the given market / internal company.'),
local_prod_creation_dt DATE
OPTIONS(description='The date when the product was created in the operational system for the given market / internal company.'),
local_list_dt DATE
OPTIONS(description='The date when the product was first listed in the given market / internal company.'),
local_delist_dt DATE
OPTIONS(description='The date when the product was removed from the assortment in the given market / internal company.'),
locked_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the product has been locked for the given market / internal company. In that case the product cannot be sold, but may still be returned.'),
brand_name STRING(100) OPTIONS(description='The name of the brand.'),
brand_type_cd STRING(20)
OPTIONS(description='The code identifying the kind of a brand. It distinguishes between own brands and other retailer brands.'),
intrastat_nr STRING(20) OPTIONS(description='The Intrastat code which identifies a certain class of products.'),
plu_nr STRING(20)
OPTIONS(description='The price lookup number is a (short) identifier for the product. It is typed into the cash register, in case the product cannot be scanned, e.g. for bread or some fruits or vegetables.'),
vat_refund_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the product is elegible for VAT refund in the given market.'),
dangerous_goods_fg BOOL NOT NULL OPTIONS(description='An indicator for hazardous material.'),
min_cust_age_meas NUMERIC(29,5)
OPTIONS(description='The minimum age for a customer who wants to purchase this product.'),
sort_seq INTEGER
OPTIONS(description='The sort order of the product on lists. The sort order is relative to the item_2 family of the product.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (prod_sid, int_org_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A product may be sold under different names, depending on the market. This entity tracks the local properties of a product.');