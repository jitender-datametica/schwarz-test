CREATE OR REPLACE TABLE szd_production_core.t_dim_deposit_item_sub_category_1 (
deposit_item_sub_cat_id INTEGER NOT NULL OPTIONS(description='The code for the item_1 return type of deposits.'),
deposit_item_cat_cd STRING(50) NOT NULL
OPTIONS(description='The category of the deposit item_1 i.e. refillable, non-refillable'),
deposit_item_sub_cat_descr STRING(250) NOT NULL
OPTIONS(description='A textual default description for the item_1 return type in Germand'),
deposit_item_sub_cat_descr_de STRING(250) NOT NULL
OPTIONS(description='A textual description for the item_1 return type in Germand'),
deposit_item_sub_cat_descr_en STRING(250) NOT NULL
OPTIONS(description='A textual description for the item_1 return type in English'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (deposit_item_sub_cat_id) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the class of deposit items');