CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_local_product_2 (
prod_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_2 organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
local_prod_nr STRING(100) NOT NULL
OPTIONS(description='The number which identifies the product within the given market / internal organization. (i.e. the local item_2 number)  Note that the product number is unique for a certain point in time, but may be re_2-used later on.'),
alt_1_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the first additional product number.'),
alt_2_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the second additional product number.'),
alt_3_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the third additional product number.'),
alt_4_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the forth additional product number.'),
alt_5_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the fifth additional product number.'),
alt_6_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the sixth additional product number.'),
alt_7_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the seventh additional product number.'),
alt_8_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the eight additional product number.'),
alt_9_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the ninth additional product number.'),
alt_10_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the tenth additional product number.'),
alt_11_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the eleventh additional product number.'),
alt_12_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the twelveth additional product number.'),
alt_13_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the thirteenth additional product number.'),
alt_14_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the forteenth additional product number.'),
alt_15_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the fifteenth additional product number.'),
alt_16_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the sixteenth additional product number.'),
alt_17_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the seventeenth additional product number.'),
alt_18_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the eighteenth additional product number.'),
alt_19_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the nineteenth additional product number.'),
alt_20_local_prod_nr STRING(100)
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. In this case, this is the twentieth additional product number.'),
alt_local_prod_nr_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='A product may be identified by more than one product number within a country_2 organization. This is the total number of additional product numbers that exist in the given country_2 organization. (Note that only the first five product numbers are stored in the columns alt_<n>_local_prod_nr.)'),
local_prod_name STRING(250) NOT NULL
OPTIONS(description='The name by which the product is marketed within the given market / internal organization. (This is the local product name.)'),
local_prod_descr STRING(250)
OPTIONS(description='A more detailed (free text) description for the product - which applies to the given market / internal organization.'),
local_prod_version_nr STRING(20)
OPTIONS(description='The version number of the product in the given market / internal company.'),
local_prod_creation_dt DATE
OPTIONS(description='The date when the product was created in the operational system for the given market / internal company.'),
plu_nr STRING(20)
OPTIONS(description='Price Lookup Code; a 4 or 5 digit code to identify items, used mostly for fruits and vegetables.'),
prod_status_cd STRING(20) NOT NULL OPTIONS(description='The code for the general lifecycle status_2 for products.'),
prod_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the general lifecycle status_2 for products. (Description in group language, i.e. in German)'),
brand_type_cd STRING(20) NOT NULL
OPTIONS(description='A code that identifies the brand_2 type. (own brand_2 vs. private brand_2)'),
brand_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the brand_2 type (own brand_2 vs. private brand_2). (Description in group language, i.e.in German)'),
brand_name STRING(100) NOT NULL OPTIONS(description='The name of the brand.'),
sup_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the supplier_2 of this product for the given country_2 organization.'),
sup_name STRING(100) NOT NULL OPTIONS(description='The name by which the supplier_2 is known.'),
buyer_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_2, who negotiated this product for the given country_2 organization.'),
buyer_nr STRING(20) NOT NULL OPTIONS(description='The number which identifies the buyer within the organization.'),
local_list_dt DATE
OPTIONS(description='The date when the product was first listed in the given market / internal company.'),
local_delist_dt DATE
OPTIONS(description='The date when the product was removed from the assortment in the given market / internal company.'),
intrastat_nr STRING(20) NOT NULL
OPTIONS(description='The Intrastat number which identifies a certain class of products.'),
intrastat_name STRING(100) NOT NULL
OPTIONS(description='The name for the Intrastat number. This is the eight-digit number. (Name in group language, i.e. in German)'),
locked_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the product has been locked for the given market / internal company. In that case the product cannot be sold, but may still be returned.'),
vat_refund_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the product is elegible for VAT refund in the given market.'),
dangerous_goods_fg BOOL NOT NULL OPTIONS(description='An indicator for hazardous material.'),
country_specific_prod_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the underlying product has been defined by only one country_2 organization and is therefore available only in one country. (This does not include products, which are defined globally, but which happen to be sold in only one country.) On product variant level this means, that this is the only variant of the product.'),
dispatch_grp_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the dispatch group, i.e. the group of products which are handled together in the logistics process.'),
dispatch_grp_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the dispatch group. (Description in group language, i.e. in German)'),
dispatch_unit_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the unit_2 of measure by which products get ordered, e.g. by pallet, by layer on a pallet, etc.'),
dispatch_unit_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the unit_2 of measure by which products get ordered, e.g. by pallet, by layer on a pallet, etc. (Description in group language, i.e. in German)'),
list_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the listing type, e.g. regular assortment, seasonal products, promotional items, etc.'),
list_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc. (Description in group language, i.e. in German)'),
order_area_nr STRING(20) NOT NULL OPTIONS(description='The number which identifies the order area.'),
order_area_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the order area. (Description in group language, i.e. in German)'),
min_cust_age_meas BIGNUMERIC(38,5)
OPTIONS(description='The minimum age for a customer who wants to purchase this product.'),
sort_seq BIGNUMERIC(38,0)
OPTIONS(description='The sort order of the product on lists. The sort order is relative to the item_2 family of the product.'),
min_consumption_day_cnt BIGNUMERIC(38,0)
OPTIONS(description='The minimum amount of life (in number of days) an item_2 must have remaining when bought by a customer.'),
min_shelflife_to_store_day_cnt BIGNUMERIC(38,0)
OPTIONS(description='The minimum amount of shelf life (in number of days) an item_2 must have remaining when delivered to a store.'),
min_shelflife_to_wh_day_cnt BIGNUMERIC(38,0)
OPTIONS(description='The minimum amount of life (in number of days) an item_2 must have remaining when delivered to the warehouse.'),
deliv_temp_meas BIGNUMERIC(38,5) OPTIONS(description='The (recommended) delivery temperature for the product.'),
min_deliv_temp_meas BIGNUMERIC(38,5) OPTIONS(description='The minimum delivery temperature for the product.'),
max_deliv_temp_meas BIGNUMERIC(38,5) OPTIONS(description='The maximum delivery temperature for the product.'),
uom_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the unit_2 of measure.'),
shelflife_check_on_receipt_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the minimum shelflife for this product shall be checked upon receipt.'),
item_fam_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the item_2 family to which this product belongs.'),
item_fam_nr STRING(100) OPTIONS(description='The number by which the related item_2 family is known to business.'),
item_fam_name STRING(100) NOT NULL
OPTIONS(description='The name of the item_2 family. (Name in group language, i.e. in German)'),
sub_item_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a sub item_2 group to which this product belongs.'),
sub_item_grp_nr STRING(100) OPTIONS(description='The number by which the related sub item_2 group is known to business.'),
sub_item_grp_name STRING(100) NOT NULL
OPTIONS(description='The name of the sub item_2 group. (Name in group language, i.e. in German)'),
int_item_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier [surrogate key] for an international item_2 group to which this product belongs.'),
int_item_grp_nr STRING(100)
OPTIONS(description='The number by which the related international item_2 group is known to business.'),
int_item_grp_name STRING(100) NOT NULL
OPTIONS(description='The name of the international item_2 group. (Name in group language, i.e. in German)'),
pillar_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the pillar, to which this product belongs.'),
pillar_nr STRING(100) OPTIONS(description='The number by which the related pillar is known to business.'),
pillar_name STRING(100) NOT NULL OPTIONS(description='The name of the pillar.(Name in group language, i.e. in German)'),
main_pillar_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the main pillar, to which this product belongs.'),
main_pillar_nr STRING(100) OPTIONS(description='The number by which the related main pillar is known to business.'),
main_pillar_name STRING(100) NOT NULL
OPTIONS(description='The name of the main pillar. (Name in group language, i.e. in German)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (prod_sid, country_org_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This dimension contains the properties of a product, as they are defined by a country_2 organization.');