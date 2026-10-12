CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_price_label_producer (
price_label_producer_name STRING(100) NOT NULL
OPTIONS(description='The name of the company that manufactures price labels.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (price_label_producer_name) NOT ENFORCED
)
OPTIONS(description='This reference table contains data about companies that manufacture price labels (Solum, Imagotag).             Sources: manually filled (ESL)');