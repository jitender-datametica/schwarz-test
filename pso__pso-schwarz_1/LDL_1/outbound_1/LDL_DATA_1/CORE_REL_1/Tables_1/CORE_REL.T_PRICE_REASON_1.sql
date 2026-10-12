CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_price_reason_1 (
price_reason_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the reason why a price was defined for a product. E.g. permanent price change, promotional price, etc.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
price_reason_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the reason why a price was defined for a product. E.g. permanent price change, promotional price, etc.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (price_reason_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the reason why a price was defined for a product. E.g. permanent price change, promotional price, etc.');