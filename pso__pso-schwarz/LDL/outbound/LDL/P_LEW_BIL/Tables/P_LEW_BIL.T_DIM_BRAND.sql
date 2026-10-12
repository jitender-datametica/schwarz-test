CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_dim_brand (
client_id BIGNUMERIC(38,0) NOT NULL,
brand_sid BIGNUMERIC(38,0) NOT NULL,
brand_name STRING(100) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);