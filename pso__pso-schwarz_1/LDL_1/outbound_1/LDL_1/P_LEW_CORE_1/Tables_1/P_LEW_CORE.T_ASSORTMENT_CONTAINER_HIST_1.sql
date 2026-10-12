CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_assortment_container_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY - Not Wawi Client'),
assortment_container_sid BIGNUMERIC(38,0) NOT NULL,
assortment_container_int_name STRING(100),
active_fg BIGNUMERIC(38,0) NOT NULL,
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (assortment_container_sid, dwh_valid_from) NOT ENFORCED
);