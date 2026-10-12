CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_price_label (
client_id BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CLIENT.'),
price_label_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key PRICE LABEL.'),
price_label_nr STRING(100) OPTIONS(description='A natural business identifier for a price label.'),
electronic_price_label_type_cd STRING(100) OPTIONS(description='The code indicating the price label type.'),
price_label_producer_name STRING(100) OPTIONS(description='The name of the company that manufactures this price label.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (price_label_sid) NOT ENFORCED
)
OPTIONS(description='Contains data about electronic price label shields - physical objects that are meant to display the current price of the items. Now contains data only about electronic price shields from source systems Solum and Imagotag.             Source: Solum, Imagotag (ESL)');