CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_wawi_item_2 (
wawi_item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the Wawi item.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_2 organization which has created the Wawi item.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_2 for which created this Wawi item. (The business country_2 is not identical to a political country.)'),
wawi_item_nr INTEGER NOT NULL
OPTIONS(description='The number which identifies the Wawi item_2 within the given country_2 organization. Note that the number is unique for a certain point in time, but may be re_2-used later on. It is also known as the short Wawi number.'),
wawi_item_name STRING(100) NOT NULL
OPTIONS(description='The name by which the Wawi item_2 is known within the given country_2 organization.'),
wawi_item_descr STRING(250)
OPTIONS(description='A more detailed (free text) description for the Wawi item_2 - which applies to the given country_2 organization.'),
wawi_item_creation_dt DATE NOT NULL
OPTIONS(description='The date when the item_2 was created in the operational system (Wawi) of the given country_2 organization. This is the create date of the first item_2 variant.'),
wawi_item_status_cd STRING(20) NOT NULL OPTIONS(description='The code for the lifecycle status_2 for Wawi items.'),
wawi_item_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status_2 for Wawi items. (Description in group language, i.e. in German)'),
item_fam_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the item_2 family to which this product belongs.'),
item_fam_nr STRING(100) OPTIONS(description='The number by which the related item_2 family is known to business.'),
item_fam_name STRING(100) NOT NULL
OPTIONS(description='The name of the item_2 family. (Name in group language, i.e. in German)'),
sub_item_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a sub item_2 group to which this product belongs.'),
sub_item_grp_nr STRING(100) OPTIONS(description='The number by which the related sub item_2 group is known to business.'),
sub_item_grp_name STRING(100) NOT NULL
OPTIONS(description='The name of the sub item_2 group. (Name in group language, i.e. in German)'),
food_fg BOOL NOT NULL OPTIONS(description='An indicator distinguishing food from non-food items.'),
int_item_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier [surrogate key] for an international item_2 group to which this product belongs'),
int_item_grp_nr STRING(100)
OPTIONS(description='The number by which the related international item_2 group is known to business.'),
int_item_grp_name STRING(100) NOT NULL
OPTIONS(description='The name of the international item_2 group. (Name in group language, i.e. in German)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (wawi_item_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='An item_2 as defined by the operational system (Wawi). Items are tangible goods which are purchased by the enterprise with the intention of selling them at a (potentially) higher price, thus generating profit. The Wawi item_2 is similar, but not identical to the global product, as Wawi items are primarily based on logistic process. E.g. Wawi creates a new item_2 if the composition of a package_2 changes or if an item_2 has a different sales_2 price. A Wawi item_2 is specific to a country_2 organization.');