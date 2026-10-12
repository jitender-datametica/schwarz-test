CREATE TABLE IF NOT EXISTS szd_core.t_dim_deposit_item_category_2 (
deposit_item_cat_cd STRING(50) NOT NULL
OPTIONS(description='The category of the deposit item_2 i.e. refillable, non-refillable'),
deposit_item_cat_descr STRING(250) NOT NULL
OPTIONS(description='A textual default description for the deposit item_2 category in German'),
deposit_item_cat_descr_de STRING(250) NOT NULL
OPTIONS(description='A textual description for the deposit item_2 category in German'),
deposit_item_cat_descr_en STRING(250) NOT NULL
OPTIONS(description='A textua description for the deposit item_2 category in English'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (deposit_item_cat_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the deposit items category i.e. refillable, non-refillable');