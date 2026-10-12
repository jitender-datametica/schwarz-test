CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_wawi_item_1 (
wawi_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the Wawi item.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_1 organization which has created the Wawi item.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_1 for which created this Wawi item. (The business country_1 is not identical to a political country.)'),
wawi_item_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The number which identifies the Wawi item_1 within the given country_1 organization. Note that the number is unique for a certain point in time, but may be re_1-used later on. It is also known as the short Wawi number.'),
wawi_item_name STRING(100) NOT NULL
OPTIONS(description='The name by which the Wawi item_1 is known within the given country_1 organization.'),
wawi_item_descr STRING(250)
OPTIONS(description='A more detailed (free text) description for the Wawi item_1 - which applies to the given country_1 organization.'),
wawi_item_creation_dt DATE NOT NULL
OPTIONS(description='The date when the item_1 was created in the operational system (Wawi) of the given country_1 organization.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (wawi_item_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='An item_1 as defined by the operational system (Wawi). Items are tangible goods which are purchased by the enterprise with the intention of selling them at a (potentially) higher price, thus generating profit. The Wawi item_1 is similar, but not identical to the global product, as Wawi items are primarily based on logistic process. E.g. Wawi creates a new item_1 if the composition of a package_1 changes or if an item_1 has a different sales_1 price. A Wawi item_1 is specific to a country_1 organization.');