CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_wawi_item_variant_1 (
wawi_item_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the Wawi item_1 variant.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
wawi_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the Wawi item_1 on which the variant is based.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_1 organization which has created the Wawi item_1 variant. (This column is denormalized from t_wawi_item.)'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_1 for which created this Wawi item. (The business country_1 is not identical to a political country.)'),
wawi_item_variant_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The number which identifies the Wawi item_1 variant within the given country_1 organization. Note that the number is unique for a certain point in time, but may be re_1-used later on. It is also known as the long Wawi number.'),
wawi_item_variant_name STRING(100) NOT NULL
OPTIONS(description='The name by which the Wawi item_1 variant is known within the given country_1 organization.'),
wawi_item_variant_descr STRING(250)
OPTIONS(description='A more detailed (free text) description for the Wawi item_1 variant - which applies to the given country_1 organization.'),
wawi_item_variant_creation_dt DATE NOT NULL
OPTIONS(description='The date when the item_1 variant was created in the operational system (Wawi) of the given country_1 organization.'),
case_size_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The number of individual items that are contained in the Wawi item_1 variant. (Note that the individual item_1 represents the smallest sellable unit. E.g. if a packed try of meat contains two slices, the entire tray is considered one sellable unit.) In case of weight-based items this is the integer part of the expected net weight of the package.'),
weight_based_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the Wawi item_1 variant is sold by weight instead of count.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (wawi_item_variant_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A Wawi item_1 can exist in various sizes, e.g. a box consisting of 10 individual items and another box consisting of 15 items. The Wawi item_1 variant describes the package_1 in which individual sales_1 units are contained. The Wawi item_1 variant is similar, but not identical to the (global) logistic variant, as Wawi items are specific to a country_1 organization and as Wawi sometimes creates multiple items for the same global product. E.g. Wawi creates a new item_1 if the composition of a package_1 changes or if an item_1 has a different sales_1 price.');