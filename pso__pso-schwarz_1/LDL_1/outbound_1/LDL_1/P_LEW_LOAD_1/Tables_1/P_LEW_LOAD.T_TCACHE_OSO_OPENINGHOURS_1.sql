CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_oso_openinghours_1 (
extraction_timestamp DATETIME,
bic_zmlila STRING(100000),
warehouseorganumber FLOAT64,
storeorganumber FLOAT64,
openinghours JSON,
load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated TIMESTAMP OPTIONS(description='The point in time when this record was last updated.')
);