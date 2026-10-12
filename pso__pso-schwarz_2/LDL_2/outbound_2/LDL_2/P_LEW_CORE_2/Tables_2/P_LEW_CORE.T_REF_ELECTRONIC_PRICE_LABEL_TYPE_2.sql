CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_electronic_price_label_type_2 (
electronic_price_label_type_cd STRING(100) NOT NULL OPTIONS(description='The code indicating the price label type.'),
price_label_producer_name STRING(100) NOT NULL
OPTIONS(description='The name of the company that manufactures price labels.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (electronic_price_label_type_cd, price_label_producer_name) NOT ENFORCED
)
OPTIONS(description='A reference table containing the different types of the electronic price labels. Different producers usualy have different types.             Sources: Solum, Imagotag (ESL)');